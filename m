Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58CD7EF2F4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345970AbjKQMtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQMtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:49:07 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824A9D56
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:49:03 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7b3d33663so21775717b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700225342; x=1700830142; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qsLyIAWXgTfFV5o66fNwdmuvFE8TfiDt0QFJ94wxiKQ=;
        b=n+KxpGXcsMw1NAwqeOnVXxBsPJ1gSWBy+0F4o9ZWxsDM9AwZDxyob2UV5C5HB28yoQ
         UwSOqc29fCes4cmIsg/wd6UxH+TgO1AR4vbw7XGOFeO8G7Y2bTYBDkHbi8RX8kS8lAqc
         cLaR+PeeTNSL+Tgn4xTDwYvg/KyEviHgbPbCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700225342; x=1700830142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsLyIAWXgTfFV5o66fNwdmuvFE8TfiDt0QFJ94wxiKQ=;
        b=wX92/uIdtEcpjr+36YALK10F/+sV2lgfj+26XKdCMnwdSNJKMOr7eqbnvCIbT9pmm/
         lx9ASbMcYjrt33AJP4n7GK7cLkJr3e/dx2EHPuHHQEUlHVArfo07pLPA6pZeuL4BG9Pj
         nTauyg0rSginke+LIi/aUcTZVOpvmm8rCxlBljGymj/mNmlbpOFcu5YZnTZjmIsKuUQO
         e99P7wsNnRC+etJTFG4CNsSSWHzMzB3/+rqVwqOomqhKsLPWMY/IMRn7dwlA6lDg0dQe
         FW/qniL5gQc3GWBAVFigCFRvY6mVK8tF8BStBMoctdJbNZf9POyTUzM4JcLtzoX0tnf1
         RsXg==
X-Gm-Message-State: AOJu0YypffcC5VZOfR3UpwOiAVpG54JI7eSFihJpjMXIivJPFZ1uvlxu
        LIEG1wCBbgty2R/N5jUVWvPj9Wd4EnE+kLJy515ioQ==
X-Google-Smtp-Source: AGHT+IHJwmmJUll6Q6aiYHmTk3AKj9Wzqt61jFGfYEYFLcNhwH/4/TrDf7KIDfEM9FdVsIPANytepQ==
X-Received: by 2002:a0d:d657:0:b0:570:2568:15e with SMTP id y84-20020a0dd657000000b005702568015emr20791289ywd.43.1700225342303;
        Fri, 17 Nov 2023 04:49:02 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id y7-20020a0def07000000b005a247c18403sm476348ywe.37.2023.11.17.04.49.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 04:49:01 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5a7c011e113so21895847b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:49:00 -0800 (PST)
X-Received: by 2002:a81:8002:0:b0:5ae:a8ac:ed6a with SMTP id
 q2-20020a818002000000b005aea8aced6amr20030337ywf.2.1700225340427; Fri, 17 Nov
 2023 04:49:00 -0800 (PST)
MIME-Version: 1.0
References: <20231026-dwc3-v2-1-1d4fd5c3e067@chromium.org> <20231031232227.xkk4ju3hxifj3vee@synopsys.com>
 <CANiDSCvEyjHFT3KQbsbURjUadpQYEfQ=M8esdcHnpWe9VsK=2w@mail.gmail.com> <20231110225507.cl6w6vkyb4dvj3uh@synopsys.com>
In-Reply-To: <20231110225507.cl6w6vkyb4dvj3uh@synopsys.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 17 Nov 2023 13:48:47 +0100
X-Gmail-Original-Message-ID: <CANiDSCu1WdKu+2Erkj9iEnp21Cuk84MC_ow+8o-qETqJH1qMNg@mail.gmail.com>
Message-ID: <CANiDSCu1WdKu+2Erkj9iEnp21Cuk84MC_ow+8o-qETqJH1qMNg@mail.gmail.com>
Subject: Re: [PATCH v2] usb: dwc3: set the dma max_seg_size
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thinh Nguyen <thinh.nguyen@synopsys.com>,
        Zubin Mithra <zsm@chromium.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg: Friendly ping, just want to make sure that the patch did not
fell into the cracks

thanks!

On Fri, 10 Nov 2023 at 23:56, Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
>
> On Fri, Nov 10, 2023, Ricardo Ribalda wrote:
> > > Probably better to have the Closes: tag with the link to the reported
> > > issue. Regardless,
> >
> > It was reported internally, so I have no link to share.
> >
>
> I see.
>
> Thanks,
> Thinh



-- 
Ricardo Ribalda
