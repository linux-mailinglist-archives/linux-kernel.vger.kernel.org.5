Return-Path: <linux-kernel+bounces-12919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E28E681FCA6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 04:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30029285F22
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 03:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7F717D1;
	Fri, 29 Dec 2023 03:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoYKo1F5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE2217C0
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 03:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2358a75b69so1131873666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 19:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703819221; x=1704424021; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIDiXG3+rJvVvjQABxQz0WXDsZkt/2/mbG2+VguXXrs=;
        b=SoYKo1F5dK1We2DCH5HiXF+H81yA3/QztVXzIgO0aUetmxREVa01SsK8BVevd869gA
         AcJS2O7n4Ey6FlajLyA8xuEs5PCTWunVuoIN8ArvRICkkQRYusCDta3UeFTDIY774cay
         9CGqfSZuFVMLx1HozURY0HevJGQjnGFD9viO6SLUqkohN3LiJff3c4e4Xme3UdRs2+Fw
         AoNQbE2DTN+ops8H4L8ihAKfjB5jqxX1YOdAi8pU7MMEl0isgO6WubS9pGIk02cUehrI
         /3sff+bfrbRYhnrOeSwfBOc76DCbNihvrEkCqN8ftHcM4xzSUfPs7Sm7VgeKgsvHAxxh
         yzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703819221; x=1704424021;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIDiXG3+rJvVvjQABxQz0WXDsZkt/2/mbG2+VguXXrs=;
        b=jvAiZEgMT5hm6BvlRpl9ThUFOZBdU5BZ2d4AQAEn8PKt2DND44n5J9AO9wvpyH2ZVf
         3KckKNkb+OrdQRjvIPgnieI5uTb9zXlk9TIViDHa6ClgctzdIhXnK6u0dCNCL4HF+qaj
         bhkveWVe17iE25Zub7+oif9K/zDUoIjfleH/9LcoWnPV9xRKgFl7QoBcwpRy95l050id
         LukqdJr90DW2nj1cRbDFKLqYDGJTkXu+SK0lMrAQB1o+I0LaxU7PcvN/3pUfqGTsZ8oF
         mkWq941P/UWdVmWy3vk07qgEOZSKQQpB+5b9uwkjoUDht56M5HaP17Jl8Vk5n044RqJN
         yptA==
X-Gm-Message-State: AOJu0YxWlFvfBJ4vG5lN4luUvKI/5U9Dw6E1DmxbJuJZI3ORh79fgluD
	4mvkm45yvEDlJAnU1j/H8lI=
X-Google-Smtp-Source: AGHT+IE4ObPyfuSIBjSJAYscwlGa3hNenXs/dfWrzdXoDM/3HE0aMK5tMchujT/jutw9WrrWWQCjEQ==
X-Received: by 2002:a17:906:74c2:b0:a26:d9f3:d3da with SMTP id z2-20020a17090674c200b00a26d9f3d3damr7765220ejl.13.1703819220571;
        Thu, 28 Dec 2023 19:07:00 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id jt6-20020a170906dfc600b00a234085cfa2sm7965462ejc.190.2023.12.28.19.06.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Dec 2023 19:06:59 -0800 (PST)
From: Wei Yang <richard.weiyang@gmail.com>
To: gregkh@linuxfoundation.org,
	masahiroy@kernel.org,
	nicolas@fjasle.eu
Cc: linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	WANG Cong <xiyou.wangcong@gmail.com>,
	Michal Marek <mmarek@suse.cz>
Subject: [PATCH 1/4] scripts/tags.sh: use more portable -path instead of -wholename
Date: Fri, 29 Dec 2023 03:06:51 +0000
Message-Id: <20231229030654.17474-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

According to the manual, -path is more portable than -wholename. Also
for consistency, let's use -path here.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
CC: WANG Cong <xiyou.wangcong@gmail.com>
CC: Michal Marek <mmarek@suse.cz>

merg
---
 scripts/tags.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index a70d43723146..fbae1a087ee1 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -50,7 +50,7 @@ fi
 find_arch_sources()
 {
 	for i in $archincludedir; do
-		prune="$prune -wholename $i -prune -o"
+		prune="$prune ( -path $i ) -prune -o"
 	done
 	find ${tree}arch/$1 $ignore $prune -name "$2" -not -type l -print;
 }
-- 
2.34.1


