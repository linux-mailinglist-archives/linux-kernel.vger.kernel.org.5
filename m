Return-Path: <linux-kernel+bounces-108929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A6188121B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382601C227AE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DF847F4A;
	Wed, 20 Mar 2024 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RH6tDIoq"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0265446DD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710940388; cv=none; b=mMUq3fbsPxpOywc3J+2trEsPjsPuuxKtFi/mEvGbxA8rI0lf/uyG4UzdcICQoNcZwBbb9W0Tgoxl5VJCupQWiB2XRDkRRG4bbtF4y/0iccMMPbrm3PjeB0nqZrNWubFkZO4Bj3yMzXUUW0nVKJJ9SaAGlq1xnlTdDbvhRUl1pbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710940388; c=relaxed/simple;
	bh=2YDNxT0fhZocPvNupmzUSE6JHPXKV+e0KiJYW7C14PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9RoWSHeZ3REM02CxWu6Dqftcf9UK4YvYt7kWTdVN/JzlmQ/Zq+XZ1ms+S+RxQkiGb8nfMj+TZv32pcXiISklzggkkf495A51dYedmp5WjgdlQrMHsw/nuaZZFBkgkQBzTmFFF2WhHo4kE/k/oGTDOuk0Af/j9qYvMuyr2wjP+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=RH6tDIoq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ecb04e018so3754649f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710940384; x=1711545184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uVomIyPH9mjZgwPoEk9ARj2Eibh5eoevRCgdrcw3zEs=;
        b=RH6tDIoqFk2GlSkPb4LZxoH5sjs5R0xVeBhqL2B7okGgmo8bUeAYJ532yYqZcfHyGJ
         sNMuIXV3Y0j4OidmhzynnEHLXMKIPu0hslFgbZrRoYViHy3bKYY6cSzcKjeg02hYj3S5
         Bl50X69E1uDoJT1WDyHPfHcI/KxQHj8CQJ/6QCxnTzbbOJvRAhFbp2cdzNm64M3c84yZ
         1ZVaBsbg4x5lQlt2kEZfhCc04wOT4NCRXHuQZX7neaC6R1D62D7s4oRA0wm2sM5KD5Rp
         nPDCakKzK/t8u9C8kS0N48vrbUdReJtsSS3cBCid5UC9EdKF2ZIdIVdIqmjsYZUurHlz
         P8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710940384; x=1711545184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVomIyPH9mjZgwPoEk9ARj2Eibh5eoevRCgdrcw3zEs=;
        b=aeYzUCUCM7rScEA3HFyw9ICkrb4tb1GbVBDQ1Dm74X1nrKmp7be/yiCR+ZV+ZjsSWw
         qfwkSSI7haFeDzHFrCR9rB9DoIfxIg04JcWL5xZoT6+s6zUe4mRmP/18C5aiybCfqEqZ
         eOTYUuoxaDTiyA+/X5zA+5p93eYy5ZDfHSIHNaVp6XNBKenFVrp9TjHbHyIXjO1spxWn
         CNU8bpmxHq5NdcB0XrIG9QKm0jj9s7fScBGijQEveuWUDsVzCLpmgjEWM790ozekPU4W
         PtuMAnGgapa/EuhqZiiDjRSwVSR9lKH13q5ZSP7Kje+0W6lb8ueFVCKUPBfgFkNljEq4
         33Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUVXg6yZNXQmBnKFxkJZiNSdtl1s/9g/ouYSBx5LqzsnaiWMN2YFA2hoNUGHkBkTBZcjS2Et+K3MJet6FLeybHhnBwzHhROiagMeqj7
X-Gm-Message-State: AOJu0YyDsklME7KOJSqZiFaZojqa8y17cHBNEXvNdYoZ2zFZJ+7e4bId
	rd/h5a9Cz3QSdeY65Wyi6xPAG5/Avs81L08Q8f9Ex4cbtKudJjk6pQYEoXm30Uo=
X-Google-Smtp-Source: AGHT+IEKYx4D63ZHfOm4QFPXok7m8sXPR0OBPYwXLg4wRMPrUAqEwyfylZFpXVcd5ndRm06b2vV/BQ==
X-Received: by 2002:a5d:4747:0:b0:33e:7f65:e4f4 with SMTP id o7-20020a5d4747000000b0033e7f65e4f4mr12573236wrs.56.1710940384083;
        Wed, 20 Mar 2024 06:13:04 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id o23-20020a5d58d7000000b0033ec5ca5665sm14657545wrf.95.2024.03.20.06.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 06:13:03 -0700 (PDT)
Date: Wed, 20 Mar 2024 14:13:02 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: krzysztof.kozlowski@linaro.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, jeremy@jcline.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, syoshida@redhat.com,
	syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com,
	syzbot+29b5ca705d2e0f4a44d2@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] nfc: nci: Fix uninit-value in nci_dev_up and
 nci_ntf_packet
Message-ID: <Zfrg3iIw6Z1JS7sA@nanopsycho>
References: <20240320005412.905060-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320005412.905060-1-ryasuoka@redhat.com>

Wed, Mar 20, 2024 at 01:54:10AM CET, ryasuoka@redhat.com wrote:
>syzbot reported the following uninit-value access issue [1][2]:
>
>nci_rx_work() parses and processes received packet. When the payload
>length is zero, each message type handler reads uninitialized payload
>and KMSAN detects this issue. The receipt of a packet with a zero-size
>payload is considered unexpected, and therefore, such packets should be
>silently discarded.
>
>This patch resolved this issue by checking payload size before calling
>each message type handler codes.

Nit. Instead of talking about "this patch" in this patch description,
you should use imperative mood to tell the codebase what to do.

https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#describe-your-changes


Patch looks ok.


>
>Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
>Reported-and-tested-by: syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com
>Reported-and-tested-by: syzbot+29b5ca705d2e0f4a44d2@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=7ea9413ea6749baf5574 [1]
>Closes: https://syzkaller.appspot.com/bug?extid=29b5ca705d2e0f4a44d2 [2]
>Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>---
>
>v2
>- Fix typo in commit message
>- Remove Call Trace from commit message that syzbot reported. Make it
>  shorter than the previous version.
>- Check the payload length in earlier code path. And it can address
>  another reported syzbot bug too. [2]
>
>v1
>https://lore.kernel.org/all/20240312145658.417288-1-ryasuoka@redhat.com/
>
>
> net/nfc/nci/core.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
>index 6c9592d05120..f471fc54c6a1 100644
>--- a/net/nfc/nci/core.c
>+++ b/net/nfc/nci/core.c
>@@ -1512,6 +1512,11 @@ static void nci_rx_work(struct work_struct *work)
> 		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
> 				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
> 
>+		if (!nci_plen(skb->data)) {
>+			kfree_skb(skb);
>+			break;
>+		}
>+
> 		/* Process frame */
> 		switch (nci_mt(skb->data)) {
> 		case NCI_MT_RSP_PKT:
>-- 
>2.44.0
>
>

