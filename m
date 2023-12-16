Return-Path: <linux-kernel+bounces-2062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3AC815769
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBAB3287489
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72C610A2B;
	Sat, 16 Dec 2023 04:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWqrv6tR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF1818EA0;
	Sat, 16 Dec 2023 04:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD19C433C8;
	Sat, 16 Dec 2023 04:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702700876;
	bh=qbPixjqMdYslzfmrhXMxSH3bQWLr5UG0Y1lVy7ic9p8=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=iWqrv6tRNmkJEzGLIY1HXibt0a3ionwOxz5W+nQK3A7TFPum1b4wpMbrF8din/Db2
	 bJxXCZIBAwihpdrVF7PpSPoMyw79OHNHfODVEVGmOoegvMzbDvDyp1w8l7773Mt8tY
	 HVPA4CHTeyTt1Ru2mJSjKk6ZyJN55uN16NrnzNWlv6xSDljrzIhVXRpKeLW3zhnz5Y
	 nbgCmH1bP12CLTTrXW929U9vSV/oAqSRbcZPhJG9DRN7oC0vB74n3GFNpSwyeVoyZ2
	 OHX1HePEVIb/FelUbidZQ6yvXUoYV0tQlDL7CZe8Pb/6kFvyu0bXgEmFJoyCtA8+4b
	 C3QaVbXLwKx+g==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-20364459774so821579fac.2;
        Fri, 15 Dec 2023 20:27:56 -0800 (PST)
X-Gm-Message-State: AOJu0Ywqa6UJgUKbt6h3EpbYxmBmF68kga5VNTHn5EHVU8ZoUy2KslUM
	8S5eZ5nV2Xsb9wfdJS9kIgT/QOiFogle2QaRQRs=
X-Google-Smtp-Source: AGHT+IHUnAnnBPTWA3VFWzP/XEn0NTTRyOAosJHWSlr08ZGatvGLLfsrr5mZrwidaa46rJ3kvPmxX5AyGYgr5OX9Qcw=
X-Received: by 2002:a05:6870:56a3:b0:203:7b73:64dd with SMTP id
 p35-20020a05687056a300b002037b7364ddmr1781512oao.104.1702700875761; Fri, 15
 Dec 2023 20:27:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:7f88:0:b0:507:5de0:116e with HTTP; Fri, 15 Dec 2023
 20:27:54 -0800 (PST)
In-Reply-To: <20231216032814.10560-1-rdunlap@infradead.org>
References: <20231216032814.10560-1-rdunlap@infradead.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 16 Dec 2023 13:27:54 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8Am1EuaNiycenCy11KcuOBcd5j9g-5FQicMusOWiL6yQ@mail.gmail.com>
Message-ID: <CAKYAXd8Am1EuaNiycenCy11KcuOBcd5j9g-5FQicMusOWiL6yQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: vfs: fix all kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

2023-12-16 12:28 GMT+09:00, Randy Dunlap <rdunlap@infradead.org>:
> Fix all kernel-doc warnings in vfs.c:
>
> vfs.c:54: warning: Function parameter or member 'parent' not described in
> 'ksmbd_vfs_lock_parent'
> vfs.c:54: warning: Function parameter or member 'child' not described in
> 'ksmbd_vfs_lock_parent'
> vfs.c:54: warning: No description found for return value of
> 'ksmbd_vfs_lock_parent'
> vfs.c:372: warning: Function parameter or member 'fp' not described in
> 'ksmbd_vfs_read'
> vfs.c:372: warning: Excess function parameter 'fid' description in
> 'ksmbd_vfs_read'
> vfs.c:489: warning: Function parameter or member 'fp' not described in
> 'ksmbd_vfs_write'
> vfs.c:489: warning: Excess function parameter 'fid' description in
> 'ksmbd_vfs_write'
> vfs.c:555: warning: Function parameter or member 'path' not described in
> 'ksmbd_vfs_getattr'
> vfs.c:555: warning: Function parameter or member 'stat' not described in
> 'ksmbd_vfs_getattr'
> vfs.c:555: warning: Excess function parameter 'work' description in
> 'ksmbd_vfs_getattr'
> vfs.c:555: warning: Excess function parameter 'fid' description in
> 'ksmbd_vfs_getattr'
> vfs.c:555: warning: Excess function parameter 'attrs' description in
> 'ksmbd_vfs_getattr'
> vfs.c:572: warning: Function parameter or member 'p_id' not described in
> 'ksmbd_vfs_fsync'
> vfs.c:595: warning: Function parameter or member 'work' not described in
> 'ksmbd_vfs_remove_file'
> vfs.c:595: warning: Function parameter or member 'path' not described in
> 'ksmbd_vfs_remove_file'
> vfs.c:595: warning: Excess function parameter 'name' description in
> 'ksmbd_vfs_remove_file'
> vfs.c:633: warning: Function parameter or member 'work' not described in
> 'ksmbd_vfs_link'
> vfs.c:805: warning: Function parameter or member 'fp' not described in
> 'ksmbd_vfs_truncate'
> vfs.c:805: warning: Excess function parameter 'fid' description in
> 'ksmbd_vfs_truncate'
> vfs.c:846: warning: Excess function parameter 'size' description in
> 'ksmbd_vfs_listxattr'
> vfs.c:953: warning: Function parameter or member 'option' not described in
> 'ksmbd_vfs_set_fadvise'
> vfs.c:953: warning: Excess function parameter 'options' description in
> 'ksmbd_vfs_set_fadvise'
> vfs.c:1167: warning: Function parameter or member 'um' not described in
> 'ksmbd_vfs_lookup_in_dir'
> vfs.c:1203: warning: Function parameter or member 'work' not described in
> 'ksmbd_vfs_kern_path_locked'
> vfs.c:1641: warning: No description found for return value of
> 'ksmbd_vfs_init_kstat'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: Steve French <sfrench@samba.org>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: linux-cifs@vger.kernel.org
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Applied it to #ksmbd-for-next-next.
Thanks for your patch!

