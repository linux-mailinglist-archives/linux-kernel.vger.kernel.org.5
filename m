Return-Path: <linux-kernel+bounces-76723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9593185FB8D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D1F1C24C98
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074BC149015;
	Thu, 22 Feb 2024 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBUvSCU9"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AE61487C5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708613377; cv=none; b=usl2ICVVf28OUsLUXGP4W8luzsQ14dG0gVyOshRKsz8mWaCUVgI8Bop66bRWLawI3cqMmtfFH5ulVBfWshn0pUMLpam3e1Q6eCc3SMg6KCp5ZHwDYuEgMVYj9NuxfgxC9Fw2DiC2nQxb0VVpMwMq9WmtDhPS4n3KbRrlwa2GBQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708613377; c=relaxed/simple;
	bh=MDErBcIbqeUZMk8fojxgvgXtvOrg5v6YksN4N5Pi+B4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XdnK4yUi9qVCX97aYP4dEipkT+/1tASqko3GUqAGgwGSpk6Hhqn8QSzQe1oMpHkRGrBNp0M50sO5847TAGhxDLfGBQu9dbJF0pRn/KYvkE76GdDQJSfHVPo79je39GWxVMU2fF3583wfn/hUa+8DNl/3quhuGk1sPyuqMzL8N/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBUvSCU9; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3e8be8a7ddso585312466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 06:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708613371; x=1709218171; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9lLClPtzfnf9PHOBVdDMjqLD7bHEiqvgFjOaWW5Ml58=;
        b=KBUvSCU9heucCg9Jfh4BeqsJcCvv8wc62dJ2rq35rEgqGevOidfxTRYi5gS2tDkyqm
         RAvASLxJQPLYSQW3zI2j1R7zMx9ddRowku7yAC0V8dvo2BrNUjsMUe44dvsMUbaayhuX
         QYvWHkDUxTtJyI6Nffs1sLN37w65T9UxRyPxeE5H8uRO8Lb0JwPjECRQ2+Ge+pXaZbK1
         Wv1uBS5Sib5w+Vu0ut/7+UomDCOJancUzTPzb3/QmlnUzgKc+C2WpV78sBVm7hV0pVL6
         iHy2ENawTxDKXHfbRmFi+EXhLUPcVHXup1s/5yA1oWaV4bY8qJn2iHlbNdxZ973WZXVL
         Vh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708613371; x=1709218171;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lLClPtzfnf9PHOBVdDMjqLD7bHEiqvgFjOaWW5Ml58=;
        b=G9DCc9+OapZLLT5nXkp67HbgRS3PcHuw43wo84TeapdFy1Wr9KWi5ptoFtTV6uadRU
         CdYNJ9gSt/vLapygxXZhcNa/NUv3fU+pQXCFvfaG4INUw+utMQqb2VbBfSjVTMPco9ck
         qElsq+vZ/xw7RKfk3ewXy88d5g975su0DpWzYqdVy+Z6FTVnNa8ZsegaJM0AV7oGvNWI
         NCofDvli3LdUwVGkJTLUAi5mi5m7qVIgHaUB6l+ivGebVcfaBSNG7gC3gkZpOydAk3Na
         +7/R8H49w82WsCzKq8AIoE6/DlEHVqU9m4+Nua9l5/F7k01SeMapw/LafDPSg5mmpiAq
         qvig==
X-Forwarded-Encrypted: i=1; AJvYcCWn5PxlMiGJqyvH8eMVxqrfvWd7LRiuOvsfZGTMTkQsvIUjTGPdybfu4WcJsVl4HTth2obG7i8F/T5B6Z0cK94EOJ3MyTlkeNIWovB7
X-Gm-Message-State: AOJu0Yyz3iXSMSJHcr4XtXnW3JzqVuJIuQ8h+JcBydIhccTtnkA6ejyQ
	oN8hf9YyLt0sI/QR35Y1iwjiPIIFhJmiQjI/WD0p6jIh+ljdfXM=
X-Google-Smtp-Source: AGHT+IF5aOjdva0sof9l//H+kjo+UqzZ/XO9Jzw06hHHsTToO7PPJVICxOvF1jtEIaZopUHEyz37fg==
X-Received: by 2002:a17:906:e2d0:b0:a3f:14f5:2f87 with SMTP id gr16-20020a170906e2d000b00a3f14f52f87mr5540346ejb.42.1708613370936;
        Thu, 22 Feb 2024 06:49:30 -0800 (PST)
Received: from p183 ([46.53.251.190])
        by smtp.gmail.com with ESMTPSA id mn6-20020a1709077b0600b00a3e12ded9b7sm5744837ejc.169.2024.02.22.06.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 06:49:30 -0800 (PST)
Date: Thu, 22 Feb 2024 17:49:28 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Gang Li <gang.li@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, ligang.bdlg@bytedance.com
Subject: Re: [PATCH v6 0/8] hugetlb: parallelize hugetlb page init on boot
Message-ID: <168a42f3-d109-4978-bf61-b91d2aef281a@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> +	static bool initialied __initdata;

Initialied?

