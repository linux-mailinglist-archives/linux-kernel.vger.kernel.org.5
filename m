Return-Path: <linux-kernel+bounces-4463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 876B3817DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4F21F2462F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84768760AD;
	Mon, 18 Dec 2023 23:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ywPnYzld"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F71876096
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 23:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d20831f21so16275e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702940740; x=1703545540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SN12il5ik6cWNDdw9fL8yyeZEss9E6x81jqC6dArM4=;
        b=ywPnYzld0rBMoq2j4ctOl/jiTkZxPMQ3Jb814gZNpN861UR3rz0wG/jSXCu/wGRsMm
         aOOI72wyDAXPUJKTOuh0cNZZLTU6DlWVTpaT73EhtisfnZVn9wxpUsjSIfWMsqGIc5ay
         2RZcxcmLpELmRhJAmxf5rGCwpf/QdvJq2JCrzg3197FqyoRwODpE/4/66WljpcDlCIq9
         svfGETYaQKA7eVz6WTB7pM8phewIYWZylTopEriEsSIrct51PTJ16Fzc2wicSpQopKl8
         pGLXNzmvqk01uXSQTVkooXwrUqUIqUpb4WLw5XFqDKk1E/d4ytYtHNcJ6TBwNNNdBlU3
         cOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702940740; x=1703545540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SN12il5ik6cWNDdw9fL8yyeZEss9E6x81jqC6dArM4=;
        b=W5XNUCMBJOk88W+V71M2xOoqicry7VRp68JTpELRpedcONnnbvp6LJHWAtMxHtB3db
         BdQV+lc9+GFMMZmwbJpoxNWWSvtY2s5sweWZJaHmKftnCeiB4bAUR2f2mkjEpYFajO0i
         MMRewKKFvPdfcNrffeU8z+BD7Jy/EB/ErL5hrNQGYQ7KhWkc+SmOHwnhyReiFnBS0N/6
         5CFJLWqiryk/GZZw99klhy3pzx3YSwYgC0AayQRek0ly/9ixl61nj9O76rcgmtBTyqqk
         vhnQYiCE82bE7jUKI0grak+LJG3JzxZ/+khxUQjQkgGn+NvnjeOu+Cuy0WxO7xVlva9A
         v37w==
X-Gm-Message-State: AOJu0YyiAGz4wF4BWlrY2jJutKVz1Wo/jhrzO9SiG3wtYf2PVJlTDbFz
	JRYY0xtK0+iccEINALPqooDEK45IXw2WNG0RUkJpMyN7Bawn
X-Google-Smtp-Source: AGHT+IGMOM3LPYj6duqgFMQpU/sRxW2c92eaacVQ5j02hlMrJxsQiJ5p6r8R1iKWvqGXXa2WKsmd/d4YW/xB4awXn9U=
X-Received: by 2002:a1c:7406:0:b0:40c:4ed3:8d1f with SMTP id
 p6-20020a1c7406000000b0040c4ed38d1fmr26310wmc.7.1702940740206; Mon, 18 Dec
 2023 15:05:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218095933.2487360-1-xuxinxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20231218095933.2487360-1-xuxinxiong@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@google.com>
Date: Mon, 18 Dec 2023 15:05:27 -0800
Message-ID: <CAD=FV=XE+k3PTXMY7gU789HnGKVQdJMwJt8gqowxT6x0zj-A4w@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add several generic edp panels
To: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	hsinyi@google.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 18, 2023 at 1:59=E2=80=AFAM Xuxin Xiong
<xuxinxiong@huaqin.corp-partner.google.com> wrote:
>
> Add support for the following 3 panels:
> 1. BOE NV116WHM-N49 V8.0
> 2. BOE NV122WUM-N41
> 3. CSO MNC207QS1-1
>
> Signed-off-by: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

0547692ac146 drm/panel-edp: Add several generic edp panels

