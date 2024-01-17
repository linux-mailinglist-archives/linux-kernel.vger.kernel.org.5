Return-Path: <linux-kernel+bounces-28969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E41C4830564
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A441C213B1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01611EB27;
	Wed, 17 Jan 2024 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYjRTOLx"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFADC1EB20
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 12:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705494908; cv=none; b=Qdd7h59/HMuAOmMIrg+SECmcbmCuQv1AlBPXVXKYB1vUdwKl85fOAmNwLF9Q7v4WyernLvbkG/R9gKxi1J+hlss3CVBGoM4SAv5oMTsr//1FLTXT3mXHs2fUwGLSvBbPK3Ev6zgjfL8aD4gL47ilKcyHD2c+Dn5yLhjGzzB4tNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705494908; c=relaxed/simple;
	bh=haxiltzcXJXGoWoGr1JuqCFCLWptv58/FApKkz9q6ho=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=BowjPQ4ikBjMxKoZvB9XAyEK7DYx20R7e0wUY8JC0WmFU9z1i+Q0pEQuLK/Nnq6d0nKP3pMzVJwBQrqpd/UJCVVHk9JoOnGg0t1Oy1BEJVtU7K5Aiu+0zvk7sjg9QAmB1j8UsgJ4qfqoR30Do75yDGm/uYvxEh3K7KRSOBZk8gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYjRTOLx; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-427ca22a680so75778141cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 04:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705494906; x=1706099706; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dykhHvJ/6o8lfs43FegK1jTNtopa0zeKcg3j2VlOAyc=;
        b=AYjRTOLxJbc2e+bYWPc/a2EvTt+V0y+JXlpk6pi8Enm10EqZEOj0W8RgdA/+iHpPVI
         rjzqwe1yScOnSWqGQio0r90cnmfNjEOSRlX4wXdIMs+irvkSK0iTQou8aioO/iz1xNn1
         ntUVVdkyaG0KSIqzmeoGGhAvtDZpSZpejc63koEcY4UasC2p9qbs13198JJlPoIjsfaN
         +p0wi+jAz+VjZA4eeZ4HE92R4OFPjF64QbmasB+uWCkzCUW0fMFVwT9MfSHXkjBLoVwj
         hkXbVlRI8J/Qql03fP3OXQi8AulTNm4afPQ3PqWVVBW5Dj7y5+szNDx3wg/E6RJOTLOG
         fa1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705494906; x=1706099706;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dykhHvJ/6o8lfs43FegK1jTNtopa0zeKcg3j2VlOAyc=;
        b=lWFnVeG0xYg7BMzYjDfsa1TjhbiRm3PXyMcpAV6S1ytMoahoyjK48scDrxQp66Z9lt
         HRYJaXVkrikIGH/LzzEowWur4UzEDPFEFPdCsAWy/Q3J8BhOsrpcqISAPNVS5HStHsbb
         p/ZnSUDucwuSfN+AKV+5KGu3PBZynRg/hg+u0CROcIdZobgsa1FG46aSNcsTPPdED3B3
         sbAwtwlKXF8VZO1Fyyh/wg2pfIT88U2pu/0CyioUm8q8TgkAHY09TfSZ6i6zvNnAu0ue
         OsDYSMrJEPafsgvf39iBH5bt4mKW0K6e7aopFzBhVc+vAMyhdCkSYAjXX5DQ4xLjfA9v
         +9cA==
X-Gm-Message-State: AOJu0YyNonjBLPo4LNwsgKWNb2KL28NzKO04eW6c1vFahQhGgpW6aJQf
	/jCmP/KPZvKz9oFFGG5lSn6Y5Eftd9GAD47CiBbtxnXUAFQ=
X-Google-Smtp-Source: AGHT+IFLvDYlCcIN8qSmtnUsWe2x/qb9lKByVGi2pCdFGhps2qsB0Vdt3AtCeoXbBmJNoljOavsZs4c8SnMQKErWJjY=
X-Received: by 2002:a05:622a:1804:b0:429:bb18:b731 with SMTP id
 t4-20020a05622a180400b00429bb18b731mr13286361qtc.120.1705494905808; Wed, 17
 Jan 2024 04:35:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110090107.26323-1-ppbuk5246@gmail.com> <21e77238-4884-40ca-bc01-b7e4774b9239@arm.com>
 <29a13c04-f669-a6c3-4693-af7e44469ad2@arm.com>
In-Reply-To: <29a13c04-f669-a6c3-4693-af7e44469ad2@arm.com>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Wed, 17 Jan 2024 12:34:54 +0000
Message-ID: <CAM7-yPRSY7rz-GCWAS1yY75kD1FUjJTF=_AdCd0LtEhQa9dssg@mail.gmail.com>
Subject: Re: [PATCH] firmware/arm_sdei: Fix invalid argument to unregister
 private events.
To: James Morse <james.morse@arm.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi James, Pierre.


> > I think you can also add:
> > Fixes: d2c48b2387eb ("firmware: arm_sdei: Fix sleep from invalid context BUG")

Thanks, I'll add this fix tag.

> >> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> >> index 285fe7ad490d..3e8051fe8296 100644
> >> --- a/drivers/firmware/arm_sdei.c
> >> +++ b/drivers/firmware/arm_sdei.c
> >> @@ -763,7 +763,7 @@ static int sdei_device_freeze(struct device *dev)
> >>       int err;
> >>         /* unregister private events */
> >> -    cpuhp_remove_state(sdei_entry_point);
> >> +    cpuhp_remove_state(sdei_hp_state);
> >
> > Maybe it would also be worth resetting 'sdei_hp_state':
> >   sdei_hp_state = 0;
>
> The next call should always be 'thaw', which doesn't check this, but it's good to cleanup
> stale values.
>
But, I think it should be checked on sdei_reboot_notifier.
otherwise, In the situation sdei device was freezed, when
sdei_reboot_notifier is called,
It would fail on cpuhp_cb_check too.

Should I add a sanity check on sdei_reboot_notifier in the next patch?

Many thanks!

