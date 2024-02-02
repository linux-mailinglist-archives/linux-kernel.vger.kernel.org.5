Return-Path: <linux-kernel+bounces-50458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B64A1847931
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734E628CC76
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FA6135DAF;
	Fri,  2 Feb 2024 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdH55ryK"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15688134CFE;
	Fri,  2 Feb 2024 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900398; cv=none; b=nIMz0FjPA6AvTjY2RwFbfW3IoiCWwnp1CTuFwIKd5h2yvJSfH6KygwBqVznJyGAgAY/e35cPTbpq5HhxSex3CYQPSMEACUyxKUU3lCc55dhnWP0sg0i8o7USxGonv5j1CVJ194z6L/rPj28AWX5U6Ic9L91v3YUyPFzx8Sbtx4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900398; c=relaxed/simple;
	bh=OZte1ELPMim44Ox4gT3tSlZVmKndVUfXpiUe/CmwwNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEczGQgJGCI7VgOJoFIhEZDGlhdsA/gM4+YTwmtqh+zbekD1HmK0oBClu/sdEgjqUbpIevagtZzR+mkV3Jb8q/Y9Or4ILm2Vr4hqP8HawnnTvnez0Ey3GVGcylaTYgoDVLIl8L3GPaRF01W5WrQ8bgs/USQ8iyMQiOg/vmqIH+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdH55ryK; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3637860f03bso8380575ab.3;
        Fri, 02 Feb 2024 10:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706900396; x=1707505196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VNMqqqrwl0s4v5C3akvNz38ZYL9ZOwAIIXiaWcyNAfY=;
        b=bdH55ryKAS/H/vUQmTXQ51QRKKBLqagmXZ4tDwRVh77mzonKOUMVKG+udzYO8T9nhd
         zLk335Ol7RpxrDwq8AT6feZavf0M3NMxYet3jwCsu2Be2lgfjX6NSAqNmQPNiO/vS7/w
         ElQphENWlwYDPVlTRqUaYo755leHXirK5vJDvo8f2Kjv4PDezgJIaxO50WbF91uukXs9
         2OJo6nZ971Q0x5nYSEnNkoBmtq+/s4ZO95+mFp/yi273gTuoXA9MmIr36PtVcEuzzt9K
         vZignu/3lrnCrE64Kqpx2jdfaLbqFPNpWtUJn9XvAdGJ8geqw/m1iY3NF5tHCrwqs4XM
         hRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706900396; x=1707505196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNMqqqrwl0s4v5C3akvNz38ZYL9ZOwAIIXiaWcyNAfY=;
        b=ZE0xGPC+OFBcoPG9EAVe2G8xUS34MMM/ISwy9iA1sLubrulPmp5/iQsTLbJbnh29P9
         oS8wVjMchVBqmhxyvZSrwRt92xNkT/l5L90ja/B47yAghQCDonKgiWsap0QtdoS4Y4H3
         SewyFs192RDkVd+Ojee7dB4eCs8jW+UVVAwypFf0zfH0d5RVsOJ607lbF4vgXG4cyYLZ
         QMP2EnJ4GLd9rlyn1aMP08llzXncxmUDjjXq6ZkHtirZ2jpnzM3dm3EiAN2wAcKf63J/
         MgnkUBgigrtt+7y31wbDejqc1Mo2T+n4DVqhti9KXzwYeSEjDD7INfX2FchDqfw82XYg
         N8QA==
X-Gm-Message-State: AOJu0YxJv6Zptf9yWSgY58JNiMCu9lqaZ7epuH6Uw8HWUDwSm8rKomRQ
	eRxY7xfXsadHkwv2NeQN3MpQUQglZhwQc6bsLihsp8VaIr3Yu0xD
X-Google-Smtp-Source: AGHT+IE4I5ZIEa0g79WwqI+BNqieerg98A9jtXD13lalZp/ALZvl/gyXdqyBFwBAl4H89UUj45a6Tg==
X-Received: by 2002:a92:de52:0:b0:363:b669:d102 with SMTP id e18-20020a92de52000000b00363b669d102mr1806905ilr.0.1706900396039;
        Fri, 02 Feb 2024 10:59:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUbEoihSiLSbVg7Ziz/lQWe1k7cYqdLTYa4/oAvUyufA6+k8SShdtU+0s6Pqp3sKwMMMjRhy1KPunkDvrs/pM25MSnDUOpXgps9r62CCF2+jqvDSLc9ntjoMlgfPHZfZ2WF4p/evclg5ZfB/wW90wBCPsVlryRdgSwVmQNsOQ+0ZzSBfHYFuHQE4FNRd7ME8Gi/DVbjacr4f6MW4DcKrzL9Zc9pBlnF8a98tGVAZCfB/oKVklj3iKgaXNKwEUdFSRMYLhpZlPhXcA+vYEYFqQ+/ZzNGzfDD2gszspzpb5hVa0tdVxYBUsBFUBKR9rHmeeDKwvb2/fOjehNPp9eEF2zBOQbCtu0F0j/ZRUS8q0UjlDDiTA4Z+sC5p3EDMTBePiwnJDCSrQbIrmcn8PTk53LEI6A6glfL7pQqWwoiRJwivlJ0sl5nLtz2T8qjkM5CACz1ltDo4JtGwg8BoshcLGaPQP/tbevb+sjtjeuMoe4BK7DLQ2WksQi/TUckp9uGhX9oKkS4NkCBzcD+Vk8CUqheBAipHUv7LAGeojxGADjXmqTP99iSmfjyJXEX6Fpczj0OeELcxHaey4jimKkymxbCPLL1ylwCrZqqKEs+ILwEmyTMslL47T64KwIbBiNc9OyHwghoM1FOT7vBN/HvqNNa5KXMCA8NtCf84AbC0onvAxRb5tpy3bCEJpuUyWFL/Fz7cxMZLhsqGAJW7ODiotOcTeZwkQUYcy9gDSH71cUZnwVvgkw4sO/xSshBLEC+DgsB+PDCFdML0wq4BLdXlpieRFpKCOfxw0s6iVSUZX1VBX+OX3TrcrYPxL7dLBxt5Z9n6JsCHUjysNFzSo3dWdKxG1Mu
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u28-20020a63141c000000b005c2420fb198sm2121371pgl.37.2024.02.02.10.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:59:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 2 Feb 2024 10:59:54 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Cosmo Chou <chou.cosmo@gmail.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jdelvare@suse.com, corbet@lwn.net,
	broonie@kernel.org, naresh.solanki@9elements.com,
	vincent@vtremblay.dev, patrick.rudolph@9elements.com,
	luca.ceresoli@bootlin.com, bhelgaas@google.com, festevam@denx.de,
	alexander.stein@ew.tq-group.com, heiko@sntech.de,
	jernej.skrabec@gmail.com, macromorgan@hotmail.com,
	forbidden405@foxmail.com, sre@kernel.org, linus.walleij@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	cosmo.chou@quantatw.com, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: trivial-devices: add Astera Labs
 PT5161L
Message-ID: <bf438d0d-978c-4252-a888-e7f6d1a6256f@roeck-us.net>
References: <20240115100518.2887549-1-chou.cosmo@gmail.com>
 <20240115100518.2887549-3-chou.cosmo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115100518.2887549-3-chou.cosmo@gmail.com>

On Mon, Jan 15, 2024 at 06:05:17PM +0800, Cosmo Chou wrote:
> Add dt-bindings for pt5161l temperature monitoring.
> 
> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied.

Thanks,
Guenter

