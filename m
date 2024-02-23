Return-Path: <linux-kernel+bounces-77884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D489B860B8E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120641C2278A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5858316436;
	Fri, 23 Feb 2024 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1mnU+ug"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C85314A8C;
	Fri, 23 Feb 2024 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708674508; cv=none; b=Pltiub71pDi9vvRyuy3wXgzLT1Btek54BKB3HY8llMdSCrFHqQU4MazgH+RrdIWuZIYUo7+wRrBd2Bw1ELCSsViQdixcnQsQAQoyaZ/esvCscR1gQuckKZdnLxYEJsHhwMJ3bijG6hzA4qiUIE3xy7Um18HASkdoXs5YcnQ1NbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708674508; c=relaxed/simple;
	bh=Gc8cEPpRnT7K/uEI11qV46cLFyoGxwzQ3spfYpGmRfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1jrQENmVbk7HB2gnj7I/BTNgH6KWXZ1aTf9iW/JiOfv3GEPKq4jWeTy1/TA6hWvWaGCtcUbNyEugRoeX18Q8wdLWqVnsvl9gGrnRB/nqXiaZxbUTPE48d6aKVLUwGa2riN4M5FxQX/ArJdWO7s1MSTLhYgWBIZpaGYU84FiMss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1mnU+ug; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc1ff697f9so5060175ad.0;
        Thu, 22 Feb 2024 23:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708674506; x=1709279306; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fdsNF2JyLvh2bfhzUEKeK8vbyn9SNnJcbP1Cgc7lhBc=;
        b=k1mnU+ugHsGiEM9yNCohtsQ9j+ADKNLLu7HrHwdjm3SYMDP4ierxOV5wSySKkcP9OG
         BsqKQLxPktFcwkyq4b5daB+V2xld6Aw9a5stsGYRTgst7hxtYqf7WqGO5L0YGv3lEMGG
         DxlSdm3uBcmg+x5UdSd7LW1V0VkCnzCsJEw7xjg0YzrLfrqlCE22LNyz+5weFaraQfNa
         pMBPT/z3Yd/+EnB5s9Nl6x1COEsFwX3SONSB3ZNFyi5/a9VlRieuq3FNcr1ECxMxT/o5
         EbuCy+9gtcd15CybGwToNyihjjsH1Yd6M07cipCpt2xuMrQQRWYoEiXp9hAMWtS3zXi0
         J1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708674506; x=1709279306;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdsNF2JyLvh2bfhzUEKeK8vbyn9SNnJcbP1Cgc7lhBc=;
        b=jYvCGIvBK6GjJs37Fd/n+M8QUIwPHUKSexkOvsFgSvfBOldq/j4gNHph+xcxSlemCm
         X/KirmYrQUBvBdGhXgMoxS7mTvsa5b12IIpcGtaQNI/uTVJ+za1rJMNaEOxmIBrLoH4/
         Nm+nhZyizdqAiDQPFkun40XBIuf7B8XLq+r391R1BOWBHGyWfMTidAIqAV7VIHYps/ps
         px4xLDsRUc2STMeN1g1eV+dg9xGt3FN1/s3kn5v7Etx/JG0MZ3on4fM/oVMwlIt/IByu
         s0DHlMykn7DLGEO929AjqZyhaAyZCeYECO7hl/LGIN6XXKSxIk2o4MLJJUpf8Dl1q37U
         kanw==
X-Forwarded-Encrypted: i=1; AJvYcCUC9qb8qoWIBC62ZMmrLfMucTaeN5HQCEDw8pFfIcLU85EF2nE1g06WoM8eY9ztRq6ojenHT+uYBZWBHFR5q9cXBXaK//Fucz82JXlyV9bzXWV1oQOI7Yhlr8FMctFYhcJLEutogeIO
X-Gm-Message-State: AOJu0YwtwKM7BbDVWKNowjQdam+I2qfxvaUpVOkc6gDZ5GsTfPipwXi/
	5ix2sUCQbAMMO5KuwZ/R+JSCD+GhHcxjZIIW3mqZONixPygYP0bG
X-Google-Smtp-Source: AGHT+IGNuq6TWqgfifsaQWW/BGbBr/8AFZyE9NWnbpCMzz2P1+lRaSIrRLLfXwHhSTllopBdNJ2BRg==
X-Received: by 2002:a17:902:d50e:b0:1db:9759:f716 with SMTP id b14-20020a170902d50e00b001db9759f716mr1016890plg.55.1708674506490;
        Thu, 22 Feb 2024 23:48:26 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902d34c00b001d8f81ecebesm10967130plk.192.2024.02.22.23.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 23:48:26 -0800 (PST)
Date: Fri, 23 Feb 2024 15:48:21 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jones Syue =?utf-8?B?6Jab5oe35a6X?= <jonessyue@qnap.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"j.vosburgh@gmail.com" <j.vosburgh@gmail.com>,
	"andy@greyhouse.net" <andy@greyhouse.net>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] bonding: 802.3ad replace MAC_ADDRESS_EQUAL
 with __agg_has_partner
Message-ID: <ZdhNxWivTVixYRFK@Laptop-X1>
References: <SI2PR04MB5097AA23EE6799B3E56C0762DC552@SI2PR04MB5097.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SI2PR04MB5097AA23EE6799B3E56C0762DC552@SI2PR04MB5097.apcprd04.prod.outlook.com>

Hi Jones,
On Fri, Feb 23, 2024 at 04:12:00AM +0000, Jones Syue 薛懷宗 wrote:
> They are verifying the same thing: if aggregator has a partner or not.
> Replaces macro with inline function would look more clear to understand.

MAC_ADDRESS_EQUAL and __agg_has_partner are not the same thing.

MAC_ADDRESS_EQUAL() is only same with __agg_has_partner() when verifying
agg partner mac addr with null_mac_addr. The description could be more
accurate.

Since you want to replace the null_mac_addr checking for MAC_ADDRESS_EQUAL().
Maybe we can also replace the null_mac_addr checking in
ad_port_selection_logic(). This should be safe as the
aggregator->partner_system and port->partner_oper.system has been compared.
e.g.

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index f2942e8c6c91..bd46dcb4013c 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1588,7 +1588,7 @@ static void ad_port_selection_logic(struct port *port, bool *update_slave_arr)
                     (aggregator->partner_system_priority == port->partner_oper.system_priority) &&
                     (aggregator->partner_oper_aggregator_key == port->partner_oper.key)
                    ) &&
-                   ((!MAC_ADDRESS_EQUAL(&(port->partner_oper.system), &(null_mac_addr)) && /* partner answers */
+                   ((__agg_has_partner(aggregator) && /* partner answers */
                      !aggregator->is_individual)  /* but is not individual OR */
                    )
                   ) {

With this the null_mac_addr definition could be removed.

Thanks
Hangbin

