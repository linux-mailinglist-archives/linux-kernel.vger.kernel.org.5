Return-Path: <linux-kernel+bounces-21789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A738829449
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36BE1F27101
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9450939AFB;
	Wed, 10 Jan 2024 07:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhgH1Zz8"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C531639ADD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3eae5c1d7so18988035ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 23:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704871700; x=1705476500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4hCFMRY+A+NO1qDRBfwFR3Up1EWuonnTR8ubqV932Y=;
        b=hhgH1Zz8QSLw7+klksPcSZjQC+Rs/kxhi8+NYfE4HeXksgyrjEfcuYMTgOebxcNIWM
         0LP4HzMDfpOF6EJ0cUQnlnnrtTz0P/AFYsmryRJZ9s3ZtSUYblpADn2+J92cyqPDO+Zp
         YoGZqx2rDAx91DcxdyTwo16NSlMRXkecj4yv7dO9hhrKtDo/9IiJzLR/DlHJG8eDqRlg
         8Pbgx5Ves5kLY/MDsc0rmDAk5ihGekKLNWlxpEnMppvB6TfHpnMzIsneruuZEFNtPkko
         H1QjFUO4E/LUC86OSzZy+ZwslCRNHleiQ9tMScoXz7DsffshoiRDVJAurP1ceA9oocGF
         x6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704871700; x=1705476500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4hCFMRY+A+NO1qDRBfwFR3Up1EWuonnTR8ubqV932Y=;
        b=sg+mCJgxXB9IwY8FJI5R0T8iBmsTFpekIyJpsrwJMVX0gy1QxUygb5OqTG2/oF1i8U
         FkbInzBrvZuTgDCxpHx5gQaNfPsQLfXqEqNXrRfRlb/kdjhYeSx3KFsFuKSKnrv0uUpd
         qkBictMKsqWiF9Wcc6nMTTGXerXeov0hMdB5kVX+2F6u7pwJfct9upb9nES/fT+tm9fW
         +z6Md1I5jdpkOfW0YxiAcemjKTcX0Q+FdVY3p8QfyFzeKUecn8B+jl5kF2mdHh5Zdx09
         6ljD7phYOlQxGSSJTyDoh2ocOVgr12WvoGO21d2IlWWfxiSOvAtoqdVyAtrxkV1ooxfR
         I7fw==
X-Gm-Message-State: AOJu0YyMf3mQ51f3S6fStaUGEQb5142OZqxp3USP0lV+HaKx1m5sfcSI
	H2eBVeZtsxjG9MAlJcYjqJ0=
X-Google-Smtp-Source: AGHT+IFzzbpaiYlnb1p+D+kIsrNquq3WKGZsYPPZZ3iMUy/KRJdb8QHeSnRfrMsXlrn4SUaG/AA7vQ==
X-Received: by 2002:a17:903:1252:b0:1d4:5a7d:21e4 with SMTP id u18-20020a170903125200b001d45a7d21e4mr496708plh.6.1704871700060;
        Tue, 09 Jan 2024 23:28:20 -0800 (PST)
Received: from mgyee-VirtualBox ([47.152.33.114])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709028a8400b001d4c9c9be42sm2929136plo.151.2024.01.09.23.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 23:28:19 -0800 (PST)
Date: Tue, 9 Jan 2024 23:28:17 -0800
From: Matthias Yee <mgyee9@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6655: fix open parentheses alignment
Message-ID: <ZZ5HEVvaGwaiGLWz@mgyee-VirtualBox>
References: <20240109205933.3221-1-mgyee9@gmail.com>
 <0efd34ef-1543-448d-a690-64e156607441@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0efd34ef-1543-448d-a690-64e156607441@moroto.mountain>

On Wed, Jan 10, 2024 at 09:53:53AM +0300, Dan Carpenter wrote:
> On Tue, Jan 09, 2024 at 12:59:34PM -0800, Matthias Yee wrote:
> > Adjusted whitespace to fix checkpatch warning Alignment Should Match Open Parenthesis.
> > 
> > Signed-off-by: Matthias Yee <mgyee9@gmail.com>
> > ---
> > Changes in v2:
> > - line wrapped commit message
> 
> Nope.  It's still 86 characters.
> 

Oops, just fixed it. Sorry about that, still new to this.

thanks,
matthias

