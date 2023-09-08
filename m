Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF499798A8C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244955AbjIHQO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbjIHQO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:14:26 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CC01739
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 09:14:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401da71b85eso24066295e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 09:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694189661; x=1694794461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U1lEtuBXbcns8c9Df/q9SbHpcHbW0xN88YLKSbiCoRw=;
        b=elna+rTnZB1mkkH5OXd9ABL5Tbv4w/IU4GnoVum/JZaaeu5Io77x2SByY8msjCXJYw
         Q6j0L5edrCosWQciGgEqRkZHg+07BRSo55y/2Hrz+QfB0yoBKmJXVTh8XzThPbcKaf33
         K0kXVyFHfHLPi6aqj3DtjZ3u8hmyRR5XqCYe8tlLbZeIFRLkTziCAuIetMJ3N7M2dnu+
         US0O2Z1UKxc+Y8ulmo6DbMhLg11qdKK6/CYSdD/o8M7QMmBI475dY97eiDg46sM+3u8x
         5HpDNUgrZ8SW1xPw1Cc8vqCLWvwGDDDpw1+vjGTuUKxZaektbMUgLDi+gky05doLYbMG
         9Tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694189661; x=1694794461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1lEtuBXbcns8c9Df/q9SbHpcHbW0xN88YLKSbiCoRw=;
        b=B+GghULdcSerBFTi2AfnLbdyy8tKQ79tKAX7mlfZqYgM4QHGxCWnsRJFHTXq+04Eoo
         ZEXuC6Ly3yzhR6wsQQRwewLEaWrQL+3sKG4qYbfd/rVOB/332GCZ+C+35mBkKhp+w9bX
         NIibteMgs/tNd81M0ips70lLo6AEJ6TwBODwuySImHopAYzRGSH3snAdNSjlWh+k4L0k
         E0B4dpqerEap8/YLYrNvw4SRDKuMPatK7nRU0QMHC9Ciq+B37+/i/u8d1sw54/ElX/Dg
         Vanab3UiGI2r7Y5LUpu7d9YLY+WMgd5S53SDY7WYPw5FOxUkmwQv85t+1ge8oTVktdeA
         G+gQ==
X-Gm-Message-State: AOJu0YxPeqSSNLnOD5xBbZejV2ZqZ761NThF9Ku8i5WfBFnhOEUsFkhV
        3CDHAX0xj14wNS3JLdrIonms9l5p9kayEIKZRzA=
X-Google-Smtp-Source: AGHT+IEfIHCl5JZjC8C/GrEcOS/jteqB4pBE9mfQdLGqHwSgttn3bJ9wxd8wJ741AikZAFN0HK7AFA==
X-Received: by 2002:a05:600c:2303:b0:3fe:785:abf9 with SMTP id 3-20020a05600c230300b003fe0785abf9mr2622090wmo.2.1694189660640;
        Fri, 08 Sep 2023 09:14:20 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s14-20020a7bc38e000000b00401d8181f8bsm5547915wmj.25.2023.09.08.09.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 09:14:20 -0700 (PDT)
Date:   Fri, 8 Sep 2023 19:14:17 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh@kernel.org>, kbuild test robot <lkp@intel.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] of: dynamic: Fix potential memory leak in
 of_changeset_action()
Message-ID: <06327197-9b17-481f-8ecc-3f9c5ba3e391@kadam.mountain>
References: <7dfaf999-30ad-491c-9615-fb1138db121c@moroto.mountain>
 <CAL_JsqJB_pK-Q-Y-v6mWV1KwfL8sjFGgCcSL5gdrZm-TqxvBJg@mail.gmail.com>
 <CAMuHMdVep4Hib0iBabGdFfbCxdftWcJ8wfySGLB8GbmbSmBNhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVep4Hib0iBabGdFfbCxdftWcJ8wfySGLB8GbmbSmBNhg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 05:34:53PM +0200, Geert Uytterhoeven wrote:
> > > Fixes: 914d9d831e61 ("of: dynamic: Refactor action prints to not use "%pOF" inside devtree_lock")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/r/202309011059.EOdr4im9-lkp@intel.com/
> >
> > Despite what that says, it was never reported to me. IOW, the added TO
> > and CC lines don't seem to have any effect.
> 
> The copy I received did list you in the "To"-header, though.
> Fall-out of the issues seen with Gmail lately?
> I do miss lots of email, too :-(

My gmail account dropped a whole lot of mail too in the last week of
August.  I was out of office that week so I didn't investigate.  I was
assuming it was an issue with vger...

regards,
dan carpenter

