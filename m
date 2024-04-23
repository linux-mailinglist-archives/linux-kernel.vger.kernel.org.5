Return-Path: <linux-kernel+bounces-154970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DE68AE3C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191661F226D6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE4A7F7EB;
	Tue, 23 Apr 2024 11:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="IGpHQCS5"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E137BB0C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871338; cv=none; b=U8zDd2MValC65kIscVyawTL1aHtw9gQQDiN+bjrldU87/USXo7bCYB5FrDIeMpn5MfdN9khSje1rSeZFJB9xGr2PkHMjUSLtwegmPan+qTxvjFYOv81PgOLhRfTcURjwlelS0IpVBR6I3nuzUYDml1sZuXOTFTu3u+TTpTX+i3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871338; c=relaxed/simple;
	bh=sbwsy7H0Q4NCfjx1+u1la9di8b5NQHCylCaYM8kjwUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyY1UdDYfIXp4DVM1jQPMUFqV/nm772iIRJzrAN+1ESmAs2RYN6lZrJnBR33WkNryUBM96z6qBLbbave5ocA/uZ72Rhz2Jerc2l6If9aSd9ROdhd992y2PXKSU5AB9YOPYeUGWuHg/AGAsGOiz3ngkv8QzsRfT7IYh4gwyNalME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=IGpHQCS5; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e1f3462caso6929929a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713871335; x=1714476135; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6GfSqgOkja5B7lN2FDN4RxNCKSJQEPLwozcaK1N5KbU=;
        b=IGpHQCS5+s1VaC2f1kJ/tONZZnTfl98KqG3qAelBDfzXrBgzE0pRRTf8w0Gim5Zizt
         guxkZFju83ec7oyrNpmAiZD7jj8wZ4nSneS+P0lVmQlVYTdYAgkB93XiLVjp9EhG5plj
         yqetoiul84CxjHRTrV6f6IOO38EcJBgDS3FTZdeWu5ORgTVJyLPfPHP3a977OiQ5i8+w
         ZSFghzZIO8kQDrBLZpFAQBH65ULYbpazbkECTMgKSw7qTn7CsLbAjyRfhEkGkDVZQaAZ
         Q7vPCVMOdApMfyUJHRvyaAqa774J+iD6UDvj+Qeu83BBYzJdUlq13X7SGiEIkw83uFu6
         XXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713871335; x=1714476135;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GfSqgOkja5B7lN2FDN4RxNCKSJQEPLwozcaK1N5KbU=;
        b=qbZLOYbNbW1lR4oUob3KJZNiQWAOEgVr8D/3E/VRA1GdNKovn4cumoHGiAHVSYoQIA
         A3/utxUr77jH6Y3uWsj0Se6aSDvBMwXzYP/hsUJrPc7qQnvXzavkLnXdqBVTDVXk+fnb
         ZYLN1Ey6WNWVJy9CZtR3Y+8wLZBEqfkq+7L0h0paICXntpJO2mgpRwwbOurbIIlvwHGP
         Gvqd1n6LTiF3gExzstVBtAsbefFB1zoHvHt2uZ0uQPGi7OT1KI2ENNxr1Rfr0aOjkAEu
         uT5Pa6pKqQbeY8Aqlx02XhvFHwZ0ujedPpx8PwZDs8ovRkcCJG9MEX3FW+W7CqMH5Z+d
         N2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCV+LuWHTzDq20zDgFYjTOfhG07lihTqqIVDPmRS2Kp8E3zycMd9vQ6/mi2oqBp7GC5rV2U4FXTBSoK1OpyuPhFSsMgqVPWWxEDU4MOR
X-Gm-Message-State: AOJu0YyViBBJtnJpPMW0eiZRNCHHqvcppDsdfIRa2/c3gIaXoJ7zP743
	BTwsBbcIIg0p+jMhmGRjqQ2nZC02iANEjkGb7W+IHFG6ZJoMS8pbUTBy7YOf8WM=
X-Google-Smtp-Source: AGHT+IGuR5GgCcJg+xPSyAb5CwWgjaYTDGRS4H6mfciAQsSwyxxjblLd3xP29uyBcvc67SkP4YONOQ==
X-Received: by 2002:a17:906:410a:b0:a55:664b:fa35 with SMTP id j10-20020a170906410a00b00a55664bfa35mr8718575ejk.6.1713871334784;
        Tue, 23 Apr 2024 04:22:14 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id z12-20020a170906270c00b00a55895c7f50sm5415223ejc.151.2024.04.23.04.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:22:14 -0700 (PDT)
Date: Tue, 23 Apr 2024 13:22:12 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next 1/2] net: sparx5: flower: cleanup
 sparx5_tc_flower_handler_control_usage()
Message-ID: <ZieZ5KM-02beFo_K@nanopsycho>
References: <20240423102728.228765-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423102728.228765-1-ast@fiberby.net>

Tue, Apr 23, 2024 at 12:27:26PM CEST, ast@fiberby.net wrote:
>Define extack locally, to reduce line lengths and future users.
>
>Only perform fragment handling, when at least one fragment flag is set.
>
>Remove goto, as it's only used once, and the error message is specific
>to that context.

3 changes, 3 patches?

>
>Only compile tested.
>
>Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>---
> .../ethernet/microchip/sparx5/sparx5_tc_flower.c    | 13 ++++++-------
> 1 file changed, 6 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
>index 663571fe7b2d..d846edd77a01 100644
>--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
>+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
>@@ -159,13 +159,14 @@ sparx5_tc_flower_handler_basic_usage(struct vcap_tc_flower_parse_usage *st)
> static int
> sparx5_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
> {
>+	struct netlink_ext_ack *extack = st->fco->common.extack;
> 	struct flow_match_control mt;
> 	u32 value, mask;
> 	int err = 0;
> 
> 	flow_rule_match_control(st->frule, &mt);
> 
>-	if (mt.mask->flags) {
>+	if (mt.mask->flags & (FLOW_DIS_IS_FRAGMENT | FLOW_DIS_FIRST_FRAG)) {
> 		u8 is_frag_key = !!(mt.key->flags & FLOW_DIS_IS_FRAGMENT);
> 		u8 is_frag_mask = !!(mt.mask->flags & FLOW_DIS_IS_FRAGMENT);
> 		u8 is_frag_idx = (is_frag_key << 1) | is_frag_mask;
>@@ -190,17 +191,15 @@ sparx5_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
> 		err = vcap_rule_add_key_u32(st->vrule,
> 					    VCAP_KF_L3_FRAGMENT_TYPE,
> 					    value, mask);
>-		if (err)
>-			goto out;
>+		if (err) {
>+			NL_SET_ERR_MSG_MOD(extack, "ip_frag parse error");
>+			return err;
>+		}
> 	}
> 
> 	st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL);
> 
> 	return err;
>-
>-out:
>-	NL_SET_ERR_MSG_MOD(st->fco->common.extack, "ip_frag parse error");
>-	return err;
> }
> 
> static int
>-- 
>2.43.0
>
>

