Return-Path: <linux-kernel+bounces-27478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3433782F0CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89BE2844AE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FCE1BF36;
	Tue, 16 Jan 2024 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3SJ/Fop"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E681BF2A;
	Tue, 16 Jan 2024 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-559c6b833b0so74879a12.1;
        Tue, 16 Jan 2024 06:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705416435; x=1706021235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UQDU3E1p1osKPCGDqpYMZ1iYLawK5EwnUnBYY4juRVc=;
        b=S3SJ/FopZ0dnO0SMLSZ9jIaPpPc9sl4BFkkPN7RR0pQ8QSUJDRUKIqV9X1bNw7yCJc
         7Lst5RJWMpe30rF91zRSdIYIibazQBSFOIz0NUTvW22X/cjC/CsYyLfY7c5cKvmyxIA4
         cFsD6z3xr8qXttiB0wrmrrIVUN39+YbJ7OlB18jBPP/ho7sABW4AZVblXmmd91a6oab5
         tZvpdgm2HEt6pBL+gkUtpVVFqrmPMkmRbPuriYxKUoguj71DbLkFN3kWYyf8FVQ+aeOC
         sgFsMdTZvy0fpzsqdRt0bSZ4k7g0kpTx7vv3M5+tz6uzTdgPP6bzl4p5f0Ih5gpyZ/01
         ZdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705416435; x=1706021235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQDU3E1p1osKPCGDqpYMZ1iYLawK5EwnUnBYY4juRVc=;
        b=C3qe35hl7RV+X3v10D/PSpq2yyIxo7UzPnpOEScgdLVCLeuLvBBPBRiVXJFiUrDn8E
         FFEWu5ubnXMzCS30Y2bNyQ6AwlmqtWiRXHpPJApZN3F5YRxMDMqU6ml1RDfG1ZjzZBgA
         asZxXxCY2XCe6XcjFxS81wuk0Ml/5vh7hhtrNItmHlx+tB6+YqUtWVmqfcgbY2Mys4KG
         6OhLsM7evjjv3ly783ftitNpauWIJ5SMW4OLCooib3cmQBpLFg2zV2rnobNEPrbqI+Yi
         QNcYE8xQtYU1ysb9yjkPX45pFPRRt9tYkw/5XJdG4jknAJUFpU1pfCSOeKIQ1mEj47Si
         THlg==
X-Gm-Message-State: AOJu0Yy5+tz1OGO9ml08I5WUR/LcvCOOfuaHIoJQz8YwADNTivGKlj/g
	FCsKe2iqc8OjRGkmYegiKSCehpsBiT1zMQ==
X-Google-Smtp-Source: AGHT+IEabsXGUeZRUV9gUXrqMMO5LSPAqVQooevyyIbe9XsJNDr5iRadStep4DBK1o2oqLwvVHV19Q==
X-Received: by 2002:a17:906:3ac2:b0:a23:6dd6:7eed with SMTP id z2-20020a1709063ac200b00a236dd67eedmr3215379ejd.77.1705416435327;
        Tue, 16 Jan 2024 06:47:15 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id cx6-20020a170907168600b00a2d5ef80043sm3788703ejd.129.2024.01.16.06.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 06:47:15 -0800 (PST)
Date: Tue, 16 Jan 2024 16:47:12 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: syzbot <syzbot+7ec955e36bb239bd720f@syzkaller.appspotmail.com>
Cc: andrew@lunn.ch, daniel@iogearbox.net, davem@davemloft.net,
	edumazet@google.com, f.fainelli@gmail.com, hkallweit1@gmail.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, pabeni@redhat.com, sd@queasysnail.net,
	syzkaller-bugs@googlegroups.com, vladimir.oltean@nxp.com,
	Edward Adam Davis <eadavis@qq.com>, Hillf Danton <hdanton@sina.com>
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in
 dsa_user_prechangeupper
Message-ID: <20240116144712.lxiw4pfjklidnrck@skbuf>
References: <00000000000002faa2060f02e766@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000002faa2060f02e766@google.com>

On Mon, Jan 15, 2024 at 01:43:20PM -0800, syzbot wrote:
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report

#syz dup: KASAN: slab-out-of-bounds Read in dsa_user_changeupper

[1] https://lore.kernel.org/netdev/0000000000001d4255060e87545c@google.com/

