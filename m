Return-Path: <linux-kernel+bounces-48971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83058463F2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB1B1F2861B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B113846426;
	Thu,  1 Feb 2024 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xv/k+7lT"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A8D44367;
	Thu,  1 Feb 2024 22:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706828390; cv=none; b=agCljuzzdzX2y0R5zF9DVRJ2EI3XLbtAt0Da2EBrO7Hhl5RECnmjdtPRP4/CvrTPYqcHRY4Wc8bY8fHGvBa1Jcf8I7spGfdPywVte4N1H1cZtlsRZAPIXdLssz89HK67998x4+Oj6wAvUTqDo5miFVkIau/YMTkatIhMu9HSKxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706828390; c=relaxed/simple;
	bh=5UeJZ9Y7zzcA7eIxK+J66T49sMJX3sYYgb8f4L27Lck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIZUm78h+cHXlZu7RDeRCu2BjBl9ByLCRewgc8+9KXIMhMtEuqnBRKrftbCYj5P8TdRFzaXxFVe4R7h75V/vsFkoHpFtKT9iWCUMY90mVVdhoO7ac3dWHk9pccpBNKAnsVk5mx9rMBir0Teu81zJsaTSx5ocBq3WgnbksI++HOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xv/k+7lT; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3566c0309fso198865566b.1;
        Thu, 01 Feb 2024 14:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706828386; x=1707433186; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nGL0/mr4ym7CKovzWGoI3YHsQx9lgpuDYhvCcxZjNiQ=;
        b=Xv/k+7lTmX2C5opjXp8wizHpCIoOU4Co9FAtq7iRjzw1K86PmxkTfde0/1Si8aI0O0
         yJKhwH0Qwq0vug4jPrAegVv6LMHMX92BhY0DhDb5Z7DyvP7AY/MWQoZxx2ppYvOdt+wE
         4nuQ2jIZb6M1nfHgdPbT/huXTzLXLDYFw+gXaoQmC6mN8bWrEYchD5VeM64uIpbUNIb9
         JONlVMIKcXdaCsURMQ+bQSB+u7u0jG/5RnXq5Cw6Dxn6t07wCfIrKYpH03s21zsMGFA8
         ZvCXti6xZIxk4gvs919/qpBiU/mC9c/DlqT4LeUyIyd3Fgar+GbqqXScUowrewSBwnid
         t1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706828386; x=1707433186;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGL0/mr4ym7CKovzWGoI3YHsQx9lgpuDYhvCcxZjNiQ=;
        b=aX8A29vfopQIgteg2DNSmGVHMxZ6//2uX2uAwWErj6ufvHFpsm6tRpK6nJOO5Ex74P
         +7AwlC0FUBW8qYnxmALLYiAhUeR0ND4GvX9ZUX92Xzf5QUpuT8hdSyyHRL9+q3umN7Xk
         rMQtXBTRDT59XJoNc9mgSQjjeOtI2B3DlsgXw4uUlMkkcqkbhKiXRf2xxlyf9BIbrdO/
         agSM3iRGT7fg88dnOJE6Z9+kaFxaxzdHoCRm8kij9mu+Pxp4sot2XCYpBSqCwlpfx8er
         hGLH18bYMpbuTvwCCpJC4SGddfnBdQvOBQLqkcj+jclEFXEKudpyZGWG30flU6SMYp05
         rpnQ==
X-Gm-Message-State: AOJu0YwOWrU9k0auL9ZPHkfsICOuQefOdOSvKkPqTySbEcEVbNSiorfv
	lIVgL7BJKmEWmAN0ks4yBWxGCPWPiSGFv2UGcxnjRbrduOf/tAkb
X-Google-Smtp-Source: AGHT+IGIXYoPWjcTqfZvpzrofTMgbbzDgUAvJiP+yvo3hM6OfjXVoirGeEBZC6wyxaP5AOcQDxoM3g==
X-Received: by 2002:a17:906:f146:b0:a36:71d9:7986 with SMTP id gw6-20020a170906f14600b00a3671d97986mr4630299ejb.2.1706828386396;
        Thu, 01 Feb 2024 14:59:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWbexIJZO3KkOMU4Ka1YWj4w3ugV+tA5R1VgJOH4BlUoayo2dLNDWpCRqNZk5r25GjvhpbQAShdTHFhx1gN/d9Hf7JdhhoVJjyJb+HWNTyf54ofjWwnlUimXJ9xakFPLdNebQSSZVSAa/vy6HXZpBMlcZ/ASdR/VhXzHXtkeYNRqTiuE3HGbxE2Al1sF0cyIG0DsUcZX5hsbTNZAD16xHRyJuhofjJJStLnQmhv4Zh5twWmkFDMsWtH751O8G9hkuorvJd7iFysM7M7Ly9/kkpWb1CG8qowAixSPjNE+gUtL0V18XpOxBiTj90e8DPC+sF2q6sBf9D/FQwV/Ft00Y7Hc9w4ty+m+vXSvfedtIF8I1MDV+Ffv8wgnKRVzHzeXbSSVFTCNFjpDbuOGLN4HiayUU3AsbhxRVymlVPeLUxA+dA4FckyKtM6T0oDYQWejANfeAxIf6ZycjoGTqiSXX94B+pyXuAf3AczRTcmwZE80SDbO16U/Gn1p0zJ2haREHd7wTnmaILn31ob9V9MntQ1qXTMI7aXoWkk2WuhEYDpGGlsTg9sWl5HdffSxXxHHmAW1Ljh4apbskNwfV3KWXs7QWZkQHqkStjzSCO+navv2WpVic5BPvpO77iRQptK7uBxAWoHpf5cQ/BSBAaok8UJcrAbQk+vtd7CycRHO3RmCvIvALUX7OnUXDCHyePe
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id h13-20020a17090634cd00b00a36ed37683fsm229705ejb.215.2024.02.01.14.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 14:59:46 -0800 (PST)
Date: Fri, 2 Feb 2024 00:59:43 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: arinc.unal@arinc9.com
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
	Frank Wunderlich <frank-w@public-files.de>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net RFC] net: dsa: mt7530: fix link-local frames that
 ingress vlan filtering ports
Message-ID: <20240201225943.abphuuavp7bkbrt6@skbuf>
References: <65bbf40d.170a0220.a87f4.becdSMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65bbf40d.170a0220.a87f4.becdSMTPIN_ADDED_BROKEN@mx.google.com>

On Thu, Feb 01, 2024 at 10:13:39PM +0300, Arınç ÜNAL via B4 Relay wrote:
> base-commit: 4e192be1a225b7b1c4e315a44754312347628859
> change-id: 20240201-b4-for-net-mt7530-fix-link-local-that-ingress-vlan-filtering-ports-6a2099e7ffb3
> 
> Best regards,
> -- 
> Arınç ÜNAL <arinc.unal@arinc9.com>

You sent this patch 3 times. What happened, b4 didn't work so well?

