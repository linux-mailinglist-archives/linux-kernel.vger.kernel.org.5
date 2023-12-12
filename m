Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A28380EDF2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376277AbjLLNqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346679AbjLLNpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:45:55 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CA8E8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:46:00 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1db99cd1b2so706558066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1702388759; x=1702993559; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CR6YV6JXDxeQ/rjFiHQEN+mV93eZyCa8/ozpNXx5zdY=;
        b=Ixahxs+dTdQgT7cfaPrk8AB/dgQtuFqnWGJ/zVC7UhP1Pjdzk3mJOAuZqPw0pKGFtt
         FGC+KkChacxpn5dYWEghV16lm0Yy0mGQb4op8gr82awrlc+m08QUkesQJnNuQG3HHxYX
         grTmUrEWnr+MiAksFlTF+FcQrnRTxQRYhFacNQAOklxQxTG5/z5V/LCroM7uJf7JJ1o2
         ANM186mP0CflfZqtipRTaR/gE/HvYuTbKZru90zDCTOekaNVylf+tOpkD++MKPPMXp80
         1hJdzBm21adU01oIoFvKJsfE/dVbytKFCMcPlc4DGXk/BoGfvM8xpNM3ypoyABIfv/Vf
         egng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702388759; x=1702993559;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR6YV6JXDxeQ/rjFiHQEN+mV93eZyCa8/ozpNXx5zdY=;
        b=IK6umH64Zu2fRhsJbD5XX61oQsMXhlFBhN+ulF8v0hLgHS9ftISfpN72MKBVNTkp7W
         kmbPD1HKrF/+ZefA+6qBEUyaMt7qjqAEHP/1r+M4wQQ2aft87i9G4YKlhfrPOPLqc19x
         8APTfzLaGppCby6zpyoGTMuA3ol7RcpD33RRlbm3whSmkcid5bHGitB9ZdPzkqfUg2Sk
         jqkipa/7fNkcrA34zynZqnHCYSqpgX6BMSMrmTTF4CU4vOZhyNOqNGqzASdmJEWDHa5V
         XvPTW85kDW47aGvLGu6vkR49bbRPr/h5KzaAMejlB8Jnl6R6DkV+vBAeZrKA/rRj6ZGG
         dOdg==
X-Gm-Message-State: AOJu0YyA2qwKkIjCd4GKCLlFxeVO7M1DlZ1DEryhEerbP+nMMbFK+DHi
        H2mXOeojvjCJ3YlUa0Lh/8+eFDLn07cxDssLKok=
X-Google-Smtp-Source: AGHT+IEFJ0vnmpojl9CH/qLn1bqqWTrJGuBttmFsV3UbQqrH8Yvp4fVhwqOcrCY3a28renNMA5BdMQ==
X-Received: by 2002:a17:907:e86:b0:a19:9b79:8b49 with SMTP id ho6-20020a1709070e8600b00a199b798b49mr2555735ejc.90.1702388758799;
        Tue, 12 Dec 2023 05:45:58 -0800 (PST)
Received: from localhost ([193.86.92.180])
        by smtp.gmail.com with ESMTPSA id tj10-20020a170907c24a00b00a1db7b77675sm6381621ejc.90.2023.12.12.05.45.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Dec 2023 05:45:57 -0800 (PST)
From:   Jiri Kosina <jkosina@suse.com>
X-Google-Original-From: Jiri Kosina <jikos@kernel.org>
Date:   Tue, 12 Dec 2023 14:45:58 +0100 (CET)
To:     Mikhail Khvainitski <me@khvoinitsky.org>
cc:     benjamin.tissoires@redhat.com, iam@valdikss.org.ru,
        jekhor@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: lenovo: Restrict detection of patched firmware only
 to USB cptkbd
In-Reply-To: <20231212133148.1000761-1-me@khvoinitsky.org>
Message-ID: <nycvar.YFH.7.76.2312121445510.24250@cbobk.fhfr.pm>
References: <CAMMabwM2jLvMHvOS151P3M7mQ9mGyAMsMcTS-HoWpeUW_GEFEg@mail.gmail.com> <20231212133148.1000761-1-me@khvoinitsky.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023, Mikhail Khvainitski wrote:

> Commit 46a0a2c96f0f ("HID: lenovo: Detect quirk-free fw on cptkbd and
> stop applying workaround") introduced a regression for ThinkPad
> TrackPoint Keyboard II which has similar quirks to cptkbd (so it uses
> the same workarounds) but slightly different so that there are
> false-positives during detecting well-behaving firmware. This commit
> restricts detecting well-behaving firmware to the only model which
> known to have one and have stable enough quirks to not cause
> false-positives.
> 
> Fixes: 46a0a2c96f0f ("HID: lenovo: Detect quirk-free fw on cptkbd and stop applying workaround")
> Link: https://lore.kernel.org/linux-input/ZXRiiPsBKNasioqH@jekhomev/
> Link: https://bbs.archlinux.org/viewtopic.php?pid=2135468#p2135468
> Signed-off-by: Mikhail Khvainitski <me@khvoinitsky.org>
> Tested-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>  drivers/hid/hid-lenovo.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index 7c1b33be9d13..149a3c74346b 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c
> @@ -692,7 +692,8 @@ static int lenovo_event_cptkbd(struct hid_device *hdev,
>  		 * so set middlebutton_state to 3
>  		 * to never apply workaround anymore
>  		 */
> -		if (cptkbd_data->middlebutton_state == 1 &&
> +		if (hdev->product == USB_DEVICE_ID_LENOVO_CUSBKBD &&
> +				cptkbd_data->middlebutton_state == 1 &&
>  				usage->type == EV_REL &&
>  				(usage->code == REL_X || usage->code == REL_Y)) {
>  			cptkbd_data->middlebutton_state = 3;

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

