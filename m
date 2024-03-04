Return-Path: <linux-kernel+bounces-91141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8D38709FD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE931C21A77
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995D278B63;
	Mon,  4 Mar 2024 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRh1vAtt"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A9E61683;
	Mon,  4 Mar 2024 18:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578762; cv=none; b=Y8Xthh1AasGrmQ7n+5neHVevPOuLvgBm5DU9w8Yi/lIKV+7EmN2+TmoN1Z4TdKsubM1tcPnRvHTlQ/Qg35UObmW7H/cUxYaK36SyyQ0NeMlJL48CCzH10JeHP6zjPggUFOi5HJSLoZT36siNRa+yR6x+fA631BZjaoohkkMs9xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578762; c=relaxed/simple;
	bh=SrEgEUchxxE3tMg9x8EJ5d4ELDsA2hu066woqJF5Xq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kneeeoQWKcVFYnPqEOPbgjCXGLo1Kj3DL+S6SJQonma2a+fpfLYFegiq39pKRed3eokhD++w7rWoXUlKIIelF41ih3kvTR6cR/QBSAROkpnVHEejE6d45S3KxEnoezUsmMDJOyWYDmwzsh4wQQ6nlegguPMQEmBWGRp90Nk6Wes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRh1vAtt; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so3519239a12.0;
        Mon, 04 Mar 2024 10:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709578761; x=1710183561; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lOKHLykfBrJ6Kxg2Tb11X80gdAjYXp6IpIbIIJIZfho=;
        b=NRh1vAttYkFcCUbndyboqrKSJJDV3p9v8xVmiCFmzFlWxIsvfZ7mgUiGsN0PynoZP9
         VeE6G4pqVezrX+rQ4GfhcjwMsJZk6RSTSkxGuoGrS9Gry55daeikZjaDzep+Fm7xG67A
         UsTf6DhmbU9653VFfGyYAlK9WUvSb2icjY6fxzoriyK7Aps9kh6lVBBHJ8shsSrb8cqu
         t8+i6Aqcc0SuyMFOGf/J67KQVejBqa/SKsD9lFJAKGToCfR0J4yKNWkkLi9pgHnInBUA
         U7S8QnxaEP2w5TcbLO4AXHCU7WIkB9enGsrV9PirFLYFjNuER693TpXnrfx0iE2wx9uY
         jT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709578761; x=1710183561;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lOKHLykfBrJ6Kxg2Tb11X80gdAjYXp6IpIbIIJIZfho=;
        b=TrL93Rd6RnAbeDCw+9u1qdFNsbxJxK4sRE5VchJJCIytbrwjCQLlFdfH4RdAw4KE7n
         kyk4NDD6oKqhiiPQ+uZwsxuBo6t4FDo+AloS2hN0R1Go1Fm5+72IItxjrFXYYKEeG5S+
         E81bX+NZWZ7Vb73XswWkyv6dG90W7v27h+nk6FH/u/7pctC+fvAJnDyiS4n6hAfaSaqb
         RyEMY5H7LZzJmTkUHZz+z5xpKooV7M5XQN74BTSUQCmwJP7zf0cEyFO3ANnOdGXcflzO
         gfqGUurZxGEwFAjonFPig7uzF5UZrK4VLKrOcbTAgsa7blIJWbSIpGcqT3s4cwk4hKFH
         HDzg==
X-Forwarded-Encrypted: i=1; AJvYcCXn6s7F8iVPLk4ILlrg9138SccOHnDCUzRHYZIRrS0gdsQfuzH5VJHdBhqg54tmPmdDjUeP+q5gfg0Z3eEex91lqHEpRgWSe90Ysm4IGpiU0AZSgBtNr97bgpTtk3DH7++PthRdGDrjQjLqvOp86cPQqENy4swNFRSu9EdS9Gjq9AfTzHHaPYUNaTs=
X-Gm-Message-State: AOJu0Yz0ysvmwTNehNKC9tO0G6HyJWpVEs5JsxD0sxqGyenwxjR7DDFT
	kXX/XitYXSUC5Gox9KsnfQsJAad4OptCYsu91dZ2+Tz+qr4jlwP6
X-Google-Smtp-Source: AGHT+IFgcAY+HWE2qY2H8NMJBgR01y1UvjSepH/qYyrYamNXp+nDk3r7L+nEIdTigfhzJV8QNaXWxg==
X-Received: by 2002:a05:6a21:328a:b0:1a0:e944:15b7 with SMTP id yt10-20020a056a21328a00b001a0e94415b7mr9756982pzb.5.1709578760576;
        Mon, 04 Mar 2024 10:59:20 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:99d7:8333:f50c:d6a6])
        by smtp.gmail.com with ESMTPSA id n22-20020aa78a56000000b006e3f09fd6a5sm7532957pfa.163.2024.03.04.10.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:59:20 -0800 (PST)
Date: Mon, 4 Mar 2024 10:59:17 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Mattijs Korpershoek <mkorpershoek@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	ye xingchen <ye.xingchen@zte.com.cn>,
	LKML <linux-kernel@vger.kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [v2] Input: iqs269a - Use scope-based resource management in
 iqs269_parse_chan()
Message-ID: <ZeYaBRcTV3N9SyNE@google.com>
References: <6bf9f962-cf75-459d-89f4-2546063fc154@web.de>
 <ZeT6UUFNq1ujMW17@google.com>
 <b5f9c66e-d9c8-4dc6-8ce5-8d1dc5f0782d@web.de>
 <ZeYAk830OUpaup5W@nixie71>
 <ZeYBTUQRAp2u3bXX@google.com>
 <ea3b033a-7a50-4276-9839-f6335b754c30@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea3b033a-7a50-4276-9839-f6335b754c30@web.de>

On Mon, Mar 04, 2024 at 06:48:58PM +0100, Markus Elfring wrote:
> > The extra curly braces are absolutely not needed. The for loop's body
> > already defines scope, __cleanup()s should be called at the end of the body.
> 
> I present an other development opinion here.
> I got the impression that the required scope should be smaller for
> the adjusted local variable “ev_node” (according to the previous function implementation).
> 
> Otherwise:
> How do you think about to move any source code part from the loop
> into a separate function?

No, it should simply look like this:


diff --git a/drivers/input/misc/iqs269a.c b/drivers/input/misc/iqs269a.c
index cd14ff9f57cf..98119c48c65f 100644
--- a/drivers/input/misc/iqs269a.c
+++ b/drivers/input/misc/iqs269a.c
@@ -557,7 +557,6 @@ static int iqs269_parse_chan(struct iqs269_private *iqs269,
 			     const struct fwnode_handle *ch_node)
 {
 	struct i2c_client *client = iqs269->client;
-	struct fwnode_handle *ev_node;
 	struct iqs269_ch_reg *ch_reg;
 	u16 engine_a, engine_b;
 	unsigned int reg, val;
@@ -734,8 +733,9 @@ static int iqs269_parse_chan(struct iqs269_private *iqs269,
 	}
 
 	for (i = 0; i < ARRAY_SIZE(iqs269_events); i++) {
-		ev_node = fwnode_get_named_child_node(ch_node,
-						      iqs269_events[i].name);
+		struct fwnode_handle *ev_node __free(fwnode_handle) =
+			fwnode_get_named_child_node(ch_node,
+						    iqs269_events[i].name);
 		if (!ev_node)
 			continue;
 
@@ -744,7 +744,6 @@ static int iqs269_parse_chan(struct iqs269_private *iqs269,
 				dev_err(&client->dev,
 					"Invalid channel %u threshold: %u\n",
 					reg, val);
-				fwnode_handle_put(ev_node);
 				return -EINVAL;
 			}
 
@@ -758,7 +757,6 @@ static int iqs269_parse_chan(struct iqs269_private *iqs269,
 				dev_err(&client->dev,
 					"Invalid channel %u hysteresis: %u\n",
 					reg, val);
-				fwnode_handle_put(ev_node);
 				return -EINVAL;
 			}
 
@@ -774,7 +772,6 @@ static int iqs269_parse_chan(struct iqs269_private *iqs269,
 		}
 
 		error = fwnode_property_read_u32(ev_node, "linux,code", &val);
-		fwnode_handle_put(ev_node);
 		if (error == -EINVAL) {
 			continue;
 		} else if (error) {

Thanks.

-- 
Dmitry

