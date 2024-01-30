Return-Path: <linux-kernel+bounces-44250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 614DF841F53
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F121F23015
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B724605B7;
	Tue, 30 Jan 2024 09:23:31 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD1960DDB;
	Tue, 30 Jan 2024 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606610; cv=none; b=Tk1fzszdgKYrUVDV3glKNW2AcqOioh8nYelJcUZ5qsvVrGfW0UDY7c34FYJ1V6/NOpn1OKy2VJkAw5fs8EqxPcf5LB1lfi+1Ms0w7ZeY291iZbRbHGWz/Hp3B2LaR9JPjQaQsWsNmyaDKGMfVFkJvFtfE0w8TUfNi6EmB8czHcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606610; c=relaxed/simple;
	bh=040hBLi3fQefc6K0iLapGpAkzbEy3B35S845VusT4+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhKwDPSJ/15aGyhecbJjUfwacCHK9OR4WnZpnGvmpG+DKNMpfTGNivEpr6QZhmfmJt1SN4SRLtLPK8k29KpchkrSTgGq/dYGcj8N5N9Ptzt/D7CD0+2sI1W0Cqri+53eeu6N3rKSlrBZ3dlzzu/UBjLVddxCD8EH92eub3/SG+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a354408e6bfso456341066b.1;
        Tue, 30 Jan 2024 01:23:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706606607; x=1707211407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuijeB7kTKzPg88klh5RjExAWGmk5spjFKXjDZFHLFg=;
        b=au3MXECgu+yARaByLeIonZbfHR/MruwGzjGiH8QUNKZV4E9nmRd53O7o8FUzCtQBFc
         XmIygZPJOr9G64yVWtIYp+tg8sXGQqb1AoXu2N2Bx8i0R5DpM2gFesRmgmt/6+qstBI+
         +JHsOX83vgokWnXt9Mu5ogOQo39AordnVGOTpAzyJXGXlEqdw44ehLa3UEUFsN6BFWE3
         6AjydEA3iNjczO7NKtE4NZ/z3yqb3A8vP3VxPI7WcQczXPjj86m1pre18MGL0FguekBX
         i5h/46r4Ck9vHxo3yG7lmRDHmedOBsFtNCK+4ObYxxzFCecAANqDlb/sFihcblBmUI1O
         uJyA==
X-Gm-Message-State: AOJu0Yy6rJ9S3inhYRFYyYVTvDyHikwCX9iLjtklfHMxQzKugFlpPXvv
	2xd91bGrCRyC7ENcMJP2uwjvN+TsS83iLTvURfxx6dxTfR/qFbIj
X-Google-Smtp-Source: AGHT+IELrXSVw+jDlDFKwJDA0VRFGH1LN4bAe38E5hOcm0xV2g9VuCNZHBnVvD4or/Q3DSewnlwObA==
X-Received: by 2002:a17:906:1d42:b0:a35:15ea:3cc0 with SMTP id o2-20020a1709061d4200b00a3515ea3cc0mr874790ejh.26.1706606607259;
        Tue, 30 Jan 2024 01:23:27 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-016.fbsv.net. [2a03:2880:31ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id ku17-20020a170907789100b00a32fb8e79e1sm4876258ejc.65.2024.01.30.01.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:23:27 -0800 (PST)
Date: Tue, 30 Jan 2024 01:23:25 -0800
From: Breno Leitao <leitao@debian.org>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/8] net: netconsole: cleanup formatting lints
Message-ID: <ZbjADdVvfHH2/yBa@gmail.com>
References: <20240126231348.281600-1-thepacketgeek@gmail.com>
 <20240126231348.281600-2-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126231348.281600-2-thepacketgeek@gmail.com>

On Fri, Jan 26, 2024 at 03:13:36PM -0800, Matthew Wood wrote:
> Address checkpatch lint suggestions in preparation for later changes
> 
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

