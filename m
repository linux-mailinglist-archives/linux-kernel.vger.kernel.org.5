Return-Path: <linux-kernel+bounces-10620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA0881D780
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 02:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DD21C21037
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 01:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF89CA4A;
	Sun, 24 Dec 2023 01:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Gd6ece58"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437E27E4
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 01:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28c05f68d1cso261857a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 17:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703381908; x=1703986708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4PCt0BUJxtEtgmlWQFvEAznyF7V0hSV/duRlgdufCo=;
        b=Gd6ece58tBCOaqajBFkBPCiZNOwKE6XX0S/O4JyRd18eSQmW8UcA8nYnqWBqSG2Nv2
         MXxE/0o3b3yh4qV93XBzi9v9ZnOrsj4igGrUu9Tbq60zheJ2w8D1SEhv3R7hNtU5LICS
         biXa1G6bobXSEcgUAfCfo/DZDvtPAppGSQTkDSqcWWccVwpKCovU8cwUTTPluIRm6oup
         9nvidfNLI1wbNO3lEIX9nElvMT+V0H3C4jP63UxW5NNV2WApX5ao3MaJvTjqaZzO2RRh
         OZyUEM8Nw0Hbyzaztwb3uxsDGTgIoh/fLYQWyJu9YRZQ2AsUZkXoN2iao19GOKutYvTe
         YrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703381908; x=1703986708;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4PCt0BUJxtEtgmlWQFvEAznyF7V0hSV/duRlgdufCo=;
        b=i+LjfC5ERgbj6kkt9BiyiNL7xZ90z9sv5BpLBQ1AzH6MK5c1mNmPdczOgZmGoe5rk+
         Wn0bmbeIkMZ6MsCv0A9rxmdC7alfg9rOn8OAfK1dMDmxnTMlg4SXn6f1zu25IyeP7dTG
         UUAZQoFx4DAhZWm94Pp5f0g+tYBCMMSyj5iyAgOzL0eD7+hb1Uy9i1exqQx9YPIWp0FD
         rbgGqlHi+CNzepWvQ0k/wrlGJJPQIasIf2LKI996tRTGgiJ5cQYjt3TFPGPT1b8Rslrc
         wMdWfJByJgTtNpwWLnC+PKX2Hew0KLGLThKDJWGX6tY0fC7z5yL2lbthOz4fd4h5xL6I
         KRwQ==
X-Gm-Message-State: AOJu0Yxyr5AyXhPZ0YW+e2V7PBob4AaV1G2znd/o+o47cSwozBRhdNs1
	EVHpE2NpgHEjBdhnKtpDPPLYXnudFgHXVA==
X-Google-Smtp-Source: AGHT+IGBrvgr5pgQQNrjr2yKzG+YadtnLw/TgftQcaHqh3uqbZcrmAcVRJmdd3rzGx3sugWBSLqC2w==
X-Received: by 2002:a05:6a00:1824:b0:6d8:f420:da04 with SMTP id y36-20020a056a00182400b006d8f420da04mr7534114pfa.0.1703381908143;
        Sat, 23 Dec 2023 17:38:28 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id f30-20020aa79d9e000000b006d9ae6fe867sm692086pfq.110.2023.12.23.17.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 17:38:27 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Coly Li <colyli@suse.de>
Cc: nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Geliang Tang <geliang.tang@suse.com>, Hannes Reinecke <hare@suse.de>, 
 NeilBrown <neilb@suse.de>, Vishal L Verma <vishal.l.verma@intel.com>, 
 Xiao Ni <xni@redhat.com>
In-Reply-To: <20231224002820.20234-1-colyli@suse.de>
References: <20231224002820.20234-1-colyli@suse.de>
Subject: Re: [PATCH] badblocks: avoid checking invalid range in
 badblocks_check()
Message-Id: <170338190635.1172668.12689831383588478650.b4-ty@kernel.dk>
Date: Sat, 23 Dec 2023 18:38:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Sun, 24 Dec 2023 08:28:20 +0800, Coly Li wrote:
> If prev_badblocks() returns '-1', it means no valid badblocks record
> before the checking range. It doesn't make sense to check whether
> the input checking range is overlapped with the non-existed invalid
> front range.
> 
> This patch checkes whether 'prev >= 0' is true before calling
> overlap_front(), to void such invalid operations.
> 
> [...]

Applied, thanks!

[1/1] badblocks: avoid checking invalid range in badblocks_check()
      commit: 146e843f6b09271233c021b1677e561b7dc16303

Best regards,
-- 
Jens Axboe




