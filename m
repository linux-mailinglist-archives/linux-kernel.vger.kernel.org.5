Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAE07BF5DA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442839AbjJJI3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442824AbjJJI3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:29:43 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF99EE0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:29:40 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-405524e6769so32222225e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696926579; x=1697531379; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=YrDpZmZefXlqy3WFlkBNTJUKRA9XMwssY5ktKEP6Rng=;
        b=Hsnnv3fIc1m7TH1rMUBq/XXbHKa/9pGFZSmM27eWflv+izae8wc40whIQbfV+4SXGS
         DpD5lfNC6hieAQ5fIUyXVDh2vrCG9QtGniL3DAHlBSQnCKEV6+GbXQSpbtnSmmwfDlsw
         buX8++UZjbZnb7OFumRcBTJ648pb9QtMUo5gWhnXE2AF/67ThOeTddyF1J874AnYANEL
         NpQLX/3TLg7pHWAc/XBxJB4vMUz+/un7TYo9Ve9WUg2f8+KSlYFf6T9HGbzx94s3ARer
         qf5jYW5gyC1Zr1Jkq4tLjPaOsDUK7tZ/+ysysIxBsn/HXkaBqO2bWDmpSTwDdUxnKpZ3
         /LKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696926579; x=1697531379;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrDpZmZefXlqy3WFlkBNTJUKRA9XMwssY5ktKEP6Rng=;
        b=OxCS0L+r3JAFRLWp2AZAlKBnL+MiIEs5ijFwrGAtMAnYZOeqx4+cSoqqUgeHzAZtOS
         0ek/Daq0oNHrVmdl4lssup/07GNstgPyK1k5/p4jpTAMovUI3HfG4CiSuPudZFItrxmn
         DEwV5jl+Qvo7ZsZg+h6IgvNLJVgY3SmRHkILSW2i07DNLfdJlzPAuBSfTbpgx8RX/HBu
         BfuVqfxtl3Alt+NBz9bNVZjy2hwrhi1yhwTfXlgL/sCi3ZTAt/SHaFkYYN9Zt1VNIhBk
         ksWVHxcv8ZvwQZ8T2XLJGAWHGywZDZ2IJh6ZHZJSDqd26yqbnRoVKtkcKGijBLZi8TIK
         4sPg==
X-Gm-Message-State: AOJu0YzbQxlYKwjGCmWODra162A1oxJgObXylEgGVmfJNgwAJBOIuPru
        7F++Uy94wCrhbEHrn/8ztASp+g==
X-Google-Smtp-Source: AGHT+IFk5wTB1OSheyR+tcxmgmgrUuRTtfgpZrtLiJ3/eRJ6WTGcqEUM2TECgII5D5zIpHI9IGCKgg==
X-Received: by 2002:a7b:c457:0:b0:401:c8b9:4b86 with SMTP id l23-20020a7bc457000000b00401c8b94b86mr13461614wmi.9.1696926578938;
        Tue, 10 Oct 2023 01:29:38 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:cb24:d0d8:242b:616c])
        by smtp.gmail.com with ESMTPSA id z23-20020a1c4c17000000b00405935b417asm15681065wmf.2.2023.10.10.01.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 01:29:38 -0700 (PDT)
References: <20231006101028.1973730-1-jbrunet@baylibre.com>
 <2023101036-ambiance-precision-657c@gregkh>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] usb: misc: onboard_usb_hub: extend gl3510 reset duration
Date:   Tue, 10 Oct 2023 10:27:32 +0200
In-reply-to: <2023101036-ambiance-precision-657c@gregkh>
Message-ID: <1jv8bex4lq.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 10 Oct 2023 at 08:56, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Fri, Oct 06, 2023 at 12:10:28PM +0200, Jerome Brunet wrote:
>> Initial tests with the gl3510 has been done on libretech aml-a311d-cc.
>> A 50us reset was fine as long as the hub node was under the usb phy node it
>> DT. DT schema does not allow that. Moving the hub under the dwc3 controller
>> caused issues, such as:
>> 
>> onboard-usb-hub 1-1: Failed to suspend device, error -32
>> onboard-usb-hub 1-1: can't set config #1, error -71
>> onboard-usb-hub 1-1: Failed to suspend device, error -32
>> onboard-usb-hub 1-1: USB disconnect, device number 2
>> 
>> Extending the reset duration solves the problem.
>> Since there is no documentation available for this hub, it is difficult to
>> know the actual required reset duration. 200us seems to work fine so far.
>> 
>> Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Fixes: 65009ccf7e8f ("usb: misc: onboard_usb_hub: add Genesys Logic gl3510 hub support")
>
> I can't find this git id, what tree is it in?

Silly mistake. I must have taken the git id I had before you merged it. Sorry.
The correct tag with usb-next is

Fixes: b447e9efe50a ("usb: misc: onboard_usb_hub: add Genesys Logic gl3510 hub support")

Should I resend it ?

>
> thanks,
>
> greg k-h

