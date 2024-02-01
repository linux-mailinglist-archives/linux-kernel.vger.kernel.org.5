Return-Path: <linux-kernel+bounces-48430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A17A8845BFA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C197297CA7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCCD626B1;
	Thu,  1 Feb 2024 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMzApyKU"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5F062179;
	Thu,  1 Feb 2024 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802330; cv=none; b=Ej2r6KQRRhfDrlLyqEnitfiqEvGpqedG0MhStST7w8EjiWKs6xjtUKLo+q6hVZMnSKE8DY3JZgIS1TyqJc7vGAtE1GURInFdyyvAqo98m4iFBov9GOP1Uc5gPvipq7o23M8rTD4fklUoorjA9Jvdmz+Nqpf1Gd2FTx5KWEnudDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802330; c=relaxed/simple;
	bh=Z7grpuTnkWfFVJfpJEHnYuRJbJeM6STBD+XYX9rbdGE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=aszV/d3tqhAtP+qduQ6JVPmBQg5ivfjZ4MjGr/8Ht0k9YlF7/8Ant69Qf9NOHK9wmMkROj6PmIru/QMbBihxh2ZGUU6jqMZ/Ey3RmY++jNcEgeuzuqo2oSCWkurVKNjB1/ggjt/n7KeJebEiSi6HaTKekMLy0dZ4TeO8B/JaESg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMzApyKU; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78541a1c5b0so94944885a.1;
        Thu, 01 Feb 2024 07:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706802328; x=1707407128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRYameA8P9vTXgG9HemCHAMfbe9mX6cBUyZCuN/wnZQ=;
        b=gMzApyKU2xkVdmW1dm0Fw/YOXxYJcvNqBHg8GkgT0/wFi/MLj7rj+If0hYA6/h+UUE
         eF8GaLgu0E64aV5pKRErkGa4QdoYneOAkFoH/+9ypKaEplvyCGOu6s9qRKk+7Cc+rZZS
         bajJws02yCcy9M5UrCwgnvWAnEsZIYRrAUleyYWyOl321izT3wqMWl7hGsQeUdiHutv/
         D8VYti/vbatHAkOQh/vmd3/fS5UHC0rrPZDk2PQuI+bZTDVuj15nYenqGsUhxj4egB2/
         m5WJ1p93D33vjNu9CwOobLWeD3Ct5sjiVG/QCim6IfvFi7SriEV1+AIstxQ/wO3filbP
         7ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706802328; x=1707407128;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TRYameA8P9vTXgG9HemCHAMfbe9mX6cBUyZCuN/wnZQ=;
        b=KWeXB1b2G2LN+MSIZDWcz+KZAD3kPCQZV82Sig4d4MUGvL46TQVwpew+h5fZbkgvuP
         LwhPxoLe5xcvGbSjH3h3vK/Z3uC++su0IBe7saYpWEYPSN8+bV5rETj4xpawnolJqPFw
         9enRVsPAGiCrknBqq+8TFsGcX7FZ/k0sbbWAnV0hnnKoeP4ATAQIIGzDXBeGgNI4iooy
         k4dPM6t66ZZWbCyq8lDM8EX3FbPTjYXW3nqbxc4PL0+31fezpRDeesJqk0myYPybaqHN
         6RHagl84F3Szgy/OiSA0PL0W/RLhDCsOFbLFSPevMffeYqkDxMp9pS3dOYDHyYU9hHcH
         pa3w==
X-Gm-Message-State: AOJu0YytG8oNeF6b3eQ3KJ7N2NbhNR4uk45SGXVjebzh9rN+PlrH04EN
	wz9UBnQH6zGdO9qvBLQoC64QzOy4uvhqWeQSLmK5FXcOOSybH9Gv
X-Google-Smtp-Source: AGHT+IHCapveW9Z+WVICc3gK1566k5UpTCufzT41ynBu6bgBVsin3omVtIFzcRED7quhZ6zn0UN0OQ==
X-Received: by 2002:a05:6214:ca9:b0:68c:444e:2bea with SMTP id s9-20020a0562140ca900b0068c444e2beamr10980669qvs.6.1706802327993;
        Thu, 01 Feb 2024 07:45:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVzP82+zqH4asKF1TXjBCPmdvUPfZGCQZdxMx7IrOgib7g8sWGEqLpHs1tq0wDY/DK/k60zGnZr6PCpwXaWWbl08pRvEXdW3+SM5yCM8VF6BQd3GJHzwwmCggCc75efyqn3+4QjAULRgXjCrd48PFB4kiCfVx6s2A5IhXDn6La9gHGE3fpAstCwuTD4ovCaUy8nZGTHRJDFwIZIi0HOnIQh4OT5woUBTfIQnbFuqZRnOIy4fTIY1iioMn8cyow=
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id mc8-20020a056214554800b0067f2559fd5esm6641056qvb.34.2024.02.01.07.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:45:27 -0800 (PST)
Date: Thu, 01 Feb 2024 10:45:27 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yunjian Wang <wangyunjian@huawei.com>, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 kuba@kernel.org, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 xudingke@huawei.com, 
 Yunjian Wang <wangyunjian@huawei.com>
Message-ID: <65bbbc9776ea4_2226992949c@willemb.c.googlers.com.notmuch>
In-Reply-To: <1706793792-20928-1-git-send-email-wangyunjian@huawei.com>
References: <1706793792-20928-1-git-send-email-wangyunjian@huawei.com>
Subject: Re: [PATCH net-next] tun: Fix code style issues in <linux/if_vlan.h>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yunjian Wang wrote:
> This fixes the following code style problem:
> - WARNING: please, no spaces at the start of a line
> - CHECK: Please use a blank line after
>          function/struct/union/enum declarations
> 
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
>  include/linux/if_tun.h | 16 +++++++++++++---

Subject: s/if_vlan/if_tun/


