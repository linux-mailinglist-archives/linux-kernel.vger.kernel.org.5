Return-Path: <linux-kernel+bounces-23299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA0782AAAD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B631F2873D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9223F125CC;
	Thu, 11 Jan 2024 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lhy2zTgw"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B51F11C94;
	Thu, 11 Jan 2024 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so4486083f8f.1;
        Thu, 11 Jan 2024 01:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704964779; x=1705569579; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0pKz3Yu/YSA1o0yNgREr/FozQgVaAcHWi4yqSk6JGiI=;
        b=Lhy2zTgwI0aWFhzxXCDXXyHeqUxtZOLNoCQLWRYO1A82hbJgpdKPUwh3vTf+C0UJ7E
         lxOybd+fsvkeC4EQXBDwh770SPJCiCnf3zCVCzNolsukcb1j4ToQQMIqmFrR7KmAKFXt
         R95uN1ZJ8UI/O9LnlBTegnlpuaq2SnWE3K9rhjmWZX2ev1fBxZWzSPkwmV562zUKB0c6
         YOi7f8rb0C2SI+gdd0aJcXSYwI5h95kt13MwS7rslEeJ8p5ESbcFbjB4CxwaLCGqpgDv
         RdClX13FcZZJJJy9usAU8cFsJbAf0PexOFEJLUikvzl2spq9brtsv3OcyCXF03GCvsrz
         iwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704964779; x=1705569579;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0pKz3Yu/YSA1o0yNgREr/FozQgVaAcHWi4yqSk6JGiI=;
        b=WYphs3u7HbW5/nPAH6Oc/RZtGUdLVaixEQnt7zq05IOCjkS2tY7HlfwhBo7Jko2f0t
         gs6jTfQpwZvL7JLPVOCZfdr9rXpx39Y5h9+Ckbsgf4L8lgrYsJq4N6PkE+BBBFschg9S
         f6PS/y0eBrVoq6a2Wx0rKxQcQdChx4OQci8tomQ9A/GVDkjGK37nbeAq89z7r1QnePlS
         k7iDjKoiuT4vnG0iw7SWVdbiLuI/tWHAG1VcGKhzbO+hciO/ZahbyReqiqPi7+ZkAPdL
         BPPHxrXz3lsa5QKEIdjsxui8qVWGPTd5pdkDe5f6zKQ2ZFEiiPJOXKjnNWOasFxUNxGd
         ZuNg==
X-Gm-Message-State: AOJu0YzrtQxvJKi4Yo783/sDSqOVmFq2tTtihmYsxuve1QlQc46+o+zP
	IECXLoBKsphSirFM5gzD/iA=
X-Google-Smtp-Source: AGHT+IHaL1yXwN7SnYCBfwLdpKbQICRvcgvZxb0jEt+hbIXtiaPUdMz70UaWXbbgf21g3tnTfyJ7Eg==
X-Received: by 2002:adf:edca:0:b0:336:c876:a407 with SMTP id v10-20020adfedca000000b00336c876a407mr488759wro.3.1704964779334;
        Thu, 11 Jan 2024 01:19:39 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id b7-20020adfe647000000b0033763a9ea2dsm692905wrn.63.2024.01.11.01.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 01:19:39 -0800 (PST)
Date: Thu, 11 Jan 2024 11:19:36 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Richard van Schagen <richard@routerhints.com>,
	Richard van Schagen <vschagen@cs.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	erkin.bozoglu@xeront.com, mithat.guner@xeront.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 08/30] net: dsa: mt7530: change p{5,6}_interface
 to p{5,6}_configured
Message-ID: <20240111091936.y3el2yp5tndcnkzn@skbuf>
References: <0542e150-5ff4-5f74-361a-1a531d19eb7d@arinc9.com>
 <7c224663-7588-988d-56cb-b9de5b43b504@arinc9.com>
 <20230610175553.hle2josd5s5jfhjo@skbuf>
 <22fba48c-054d-ff0a-ae2c-b38f192b26f7@arinc9.com>
 <9308fa1a-6de3-490b-9aeb-eb207b0432df@arinc9.com>
 <9308fa1a-6de3-490b-9aeb-eb207b0432df@arinc9.com>
 <20240110142721.vuthnnwhmuvghiw4@skbuf>
 <b47311f8-315d-46d9-bd5b-757141708a3f@arinc9.com>
 <20240110180525.wwxkkoqam37oqm2f@skbuf>
 <ZZ7ib5WWyH4TyirS@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZZ7ib5WWyH4TyirS@shell.armlinux.org.uk>

On Wed, Jan 10, 2024 at 06:31:11PM +0000, Russell King (Oracle) wrote:
> On Wed, Jan 10, 2024 at 08:05:25PM +0200, Vladimir Oltean wrote:
> > On Wed, Jan 10, 2024 at 08:15:20PM +0300, Arınç ÜNAL wrote:
> > > __builtin_return_address(1) doesn't seem to work. I'm running this on arm64.
> > 
> > I can't tell you why either, I'm sorry. I can just point to the
> > documentation, which does specify that "On some machines it may be
> > impossible to determine the return address of any function other than
> > the current one". If somebody knows what this depends on, feel free to
> > interject.
> > https://gcc.gnu.org/onlinedocs/gcc/Return-Address.html
> > 
> > On my NXP LS1028A (also arm64) plus clang-16 compiler, __builtin_return_address()
> > does work with multiple nesting levels.
> 
> gcc will probably need to be using frame pointers so it can walk the
> stack, if gcc even implements non-zero values to
> __builtin_return_address(). Without frame pointers, it would need an
> unwinder.

Yeah, I guess it's a gcc limitation. I recompiled the kernel for the same
platform with gcc 11.2 from Arm, and I get the same result as Arınç now.

