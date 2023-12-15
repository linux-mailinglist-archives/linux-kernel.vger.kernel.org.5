Return-Path: <linux-kernel+bounces-821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2ED8146A2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65931C210FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD4F2C698;
	Fri, 15 Dec 2023 11:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/zVvaE6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D447F2556E;
	Fri, 15 Dec 2023 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3b9e1a3e3f0so405858b6e.1;
        Fri, 15 Dec 2023 03:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702639020; x=1703243820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLkJMM9DCab1jUL3ywOV/kzfDGhJU5IagWi1Fm0lmhM=;
        b=e/zVvaE6bN81xB2ZcF5U5KSFyR9yphEMGtbRJORJz3tIH10eHdtuG1EqJS+BaVikm8
         yXbx44iodABIbQAJphUX8BlnPVsc69gXqMk+P4NZKXukv5QTy9N5DT4/sK6SJu8ie7Jc
         8BUjy+o/ifG48cMWfA59WjKayo4TfXbak3TOWGuLkDR1dXEvmu7Qv11S7+xDIwjzeFWA
         uLrzynQsfI3ZdAqZS0e6FZpU+BR25xKst70nxIbOQssrHyOBA9RuXoPepnGcRfEyTkyM
         H0zU3+RO+rsf3Z8OKxa/m4HpTjfjOYxDeQdT9z8Ghj49cHZ4YQ6UcDfYWXq52xuhtK8Y
         Ps/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702639020; x=1703243820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLkJMM9DCab1jUL3ywOV/kzfDGhJU5IagWi1Fm0lmhM=;
        b=gt3b9LKIklAPpXnSIhIT0i4/UgtwNN8QBDhJ+RFlYGICuL/BVK7IqmyUZFxkJQ7wEo
         /ax/NvdniPdjcsWXO2WNKw9LswLxXUnIHflV4FZvg+THUdWkP0VxbfP5ypxrY3E5QLK0
         NAnuP4J0BgroNkQ8GM5OTiHT1Q6X+qzavZDuSWoU6JofPo7hyTJOHZEaBJUQE4tCokKF
         /BJgpSbQ8DM3vMrKbvJlrxInhwWXQJsd3LLXIpO+VxCR5lDpxrA7iETjeyzEYgU4QppQ
         5UY2JM/ZlQHuLSAYkHe7XxCd3wLl7+RVuvI8XLpZyxNc6VIVlwvotc8UTPGKAhDPBdcr
         kDww==
X-Gm-Message-State: AOJu0YzvjaE/10wTdYINqCRrifCYhx7t/RfSjP3yMp3GRM4d422zv7u2
	VjVJklsJTKRdQXU4CbXldHf+tZrvP3tAqqKyvBQ=
X-Google-Smtp-Source: AGHT+IE6TmWubCkEC1dWBUYJlK8dhq/P+LNxUWyFvOaI1YMrxUMWXv9M10VKTLC3NL+NAR89QGcT8C2TBqXImPajgSg=
X-Received: by 2002:a05:6808:120e:b0:3b8:b063:a1c7 with SMTP id
 a14-20020a056808120e00b003b8b063a1c7mr13832820oil.81.1702639020528; Fri, 15
 Dec 2023 03:17:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202312151817+0800-wangjinchao@xfusion.com>
In-Reply-To: <202312151817+0800-wangjinchao@xfusion.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 15 Dec 2023 13:16:49 +0200
Message-ID: <CAOQ4uxhoYTtnwKX0k3GwORWzJaYAJwpxu9B-ONu5Y0gdkavo8g@mail.gmail.com>
Subject: Re: [PATCH] fs: remove duplicated including of posix_acl.h
To: Wang Jinchao <wangjinchao@xfusion.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stone.xulei@xfusion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 12:17=E2=80=AFPM Wang Jinchao <wangjinchao@xfusion.=
com> wrote:
>
> remove the second including of linux/posix_acl.h
>
> Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
> ---
>  fs/overlayfs/inode.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index c63b31a460be..2003425875d9 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -14,7 +14,6 @@
>  #include <linux/fileattr.h>
>  #include <linux/security.h>
>  #include <linux/namei.h>
> -#include <linux/posix_acl.h>
>  #include <linux/posix_acl_xattr.h>
>  #include "overlayfs.h"
>

Since both posix_acl.h and posix_acl_xattr.h are included by overlayfs.h
I would rather remove them both including the first posix_acl.h include.

It is far from being the only duplicate include in "overlayfs.h" and it is =
not
important enough IMO to start a cleanup project, but if you are going to
tidy up includes for a particular file, I'd rather use the opportunity to
cleanup that duplicity as well.

Thanks,
Amir.

