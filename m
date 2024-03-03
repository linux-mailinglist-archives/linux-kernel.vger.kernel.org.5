Return-Path: <linux-kernel+bounces-89717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC3086F4A3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 12:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43939B21D50
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 11:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034D4BE5B;
	Sun,  3 Mar 2024 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lMffPfTP"
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DD9BE48
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709466774; cv=none; b=JgW+LPgnLy5BHGAWYGM4O8CLz9K2zlpYeosxvFbEr4qk9UHGss6e5wUiXaOLTUN1oCZ7hTJZyw6qorVQRUV46kETpSpJr2lZSVvqvoWch2EzvW4o4xrmGD8mbHJ17xC53C8G2BnzdcuvG6RDa6M1Tin7bE1U1LwKAgJuyG44AKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709466774; c=relaxed/simple;
	bh=6O3MEpm0Y4AStwCVFXGmlpgVaNsNpnXJvOK4VyQqWxs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Dtnf3E4cGyiGXvBf43JuBLCAGRlgBpDN6a3b5VW4mxDPyqfneyRi7KfDFycoEwYLAvsk4gcHGdODR5e7aj7HASGUiSWIvmUUDczx9LTWbCpc/Vie8wIO05nutvGAQUrKzEzw5EcYSDQ8koUn4ebV4UUAklJHmaDoLp5amo8ZCgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lMffPfTP; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709466769; bh=DWQfP/VPsnzHv398WDomEW70GNsznKRGKOkuUEm1iuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lMffPfTPjG01Z4NuPuCC5Hh32cIJHgFtQ+v2gTnUAN8UzLlqXhcYFQOOcA/Ng0vSx
	 3ArAwcGFah6ms7N977Rea9cyN1qPcBRNFfX7n2fTikdVE3rIC7Ymi1X8iDqeE7DDnx
	 lEhc56LPBZErHHR/R9/VqnI2oS+Jh210AEJtIMHI=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id D3029086; Sun, 03 Mar 2024 19:52:48 +0800
X-QQ-mid: xmsmtpt1709466768tiz3q6kxo
Message-ID: <tencent_FB46CF407B6A6CBC2C596F7C97BCE8EEEE0A@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMmaP+1mcOH883vq/+M6jorP655z+GGLQOKO5QYlfCMVCYi2EKfR69
	 qP3yp7bhi/HG99nVtJTdN05AuBJ67BWUeatRX28IVFVSpoebdVwbMvi/JrSKVO41ysMML30bHyFf
	 qdTt5J50225hKuVK4bf3HCh5jIZMI6XXt/UoahcuXny+5o/UhaKEQc/6ceBg1TBF7k7kw+q61cTW
	 FdmWyM39qijCR4eKx4GHWteruL0A8kjIccd19R46Yt0NkdTf73u7Lc7/Rej+Ud+PteSyyldp31xS
	 Y1mqWJKLYQh1eDJhboXp0qH0h3ZJZdnZsZ6VEm9jXWF7TijYd4sku3mCLWhc6kQNj3dGdH7EfqCF
	 EKiilRtFWzTQQ3PpvTXxCIV8Bq9pkOC4OVDq/Lw0shEzl5Rm150sIiUg9SKQK2VPNwj8IVZtH/ER
	 4CoZpuw8MsTKYWsN8mjZmzhIicM801KM8a9+U1lER/bsHEJPW0UzqZr1ZRjLM9icRHIZxbGgz2sV
	 i4243SzvjiEwHdhKmuFrZCAFs8tFD68OI5ni9gHhbHS1unxUkCPK/UuZkH3dAVnUDIrqlXGIsA33
	 5s955I++w9OOJmQI27DitNruMtiKlrjsaIhnLEoIwAVJ3Opi7WF9Qn0Zal6PaonM/1VMAFHowT9+
	 COuXEsIAEkGhcQbbJjd4wB2UuJpMW8brB6ONqzEPY75RxIAl5GEfXWA3xw0Xfpb1GsVRXgPoRfS9
	 3xIFY0CNuuWqRCJTDyrj5Zz6MoNdnkawkDNMM6Ab1Mt9E2WKgWbK9sB1CrUVbAz5GxhLBbWVdRa8
	 tmlb77AUPgBMEfkqE9/Krq79TGfVDWvMsD70oK1FD3uDUY6GfUFKdSg83QiBtq8+ixjmmKbtd3+m
	 +s2JQXn1wT6aJv+oGZpygSNAenbhdHphGfo+a3YoAVmtecjpg32Sjf4zjRb6oWeryuCeYBQpi/cx
	 pV3pQ6GDM=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f770ce3566e60e5573ac@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hams?] KMSAN: uninit-value in nr_route_frame
Date: Sun,  3 Mar 2024 19:52:48 +0800
X-OQ-MSGID: <20240303115248.552050-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000b69bf20612bf586e@google.com>
References: <000000000000b69bf20612bf586e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uninit-value in nr_route_frame

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index edbbef563d4d..c8662be35000 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -656,6 +656,7 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 	 * to allow max possible filling before reallocation.
 	 */
 	prefetchw(data + SKB_WITH_OVERHEAD(size));
+	memset(data, 0, sizeof(*data));
 
 	/*
 	 * Only clear those fields we need to clear, not those that we will


