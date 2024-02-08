Return-Path: <linux-kernel+bounces-57697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A943384DC7A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4866A1F22F8B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEC56BB55;
	Thu,  8 Feb 2024 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsJPd4uB"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FDB6BB46;
	Thu,  8 Feb 2024 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383459; cv=none; b=cV+CEP2+zAmk3JjvQVNxkWeYZnLDEAfWvLL2qMHLWxot0efBeMGEYzuB2yc59sC1J8VHuNsmh51036RbKbF59vat3pma/Jii+XIjln/BU98gvQ5AdCuqS0oSLR8hbeDVrOH3HyT8LajlxHQL9G+eUBhihBas79b3lPnQ8o1TTBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383459; c=relaxed/simple;
	bh=XTItBWIPLNi1ruKfQXimlR8ToFhWiDyjrNOkTpIjJ+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nMiLKYoLRfPinPy0SlLgMFDnWib0aZaxb4dKOdtbEHgzlgWcbsoBX5x1r1tQzQKAeAUCzzL1Jk2H+C4Lb/wdQ1773xpFUHirILPSwYvGJyL7VUUHJnmQeDURgqCXxW+LwdOFvRrJhtAL3ZpwKmuZFmv5TuEE6DYhG3h2/LHa7MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsJPd4uB; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so1924156a12.1;
        Thu, 08 Feb 2024 01:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707383455; x=1707988255; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SgZIIpOjpH8X4ZedBeUEAEFmQnSOxMry/KstJ3anrUk=;
        b=XsJPd4uBJunGWwNk64iJoQBDDv7EPozKNIy66/VpqSr1uNM17JvKIrQeIKk039iqRc
         vGdMrn8YTORGxz4ZUkMp/Co57LPA579slu22ADuAJu5tE8Ium197susA5RCEEko8Vkxw
         BsEUDyQhm5LihYsDgzsoYZ0lv09O1gHVUDBEzDEsafjhn1DGRvd1ixEE9fk9Md6fUFJi
         ZP4ocInAtTiZLVdp8CrbuCGVfnUzqCObKuh6b1vLiI9Rzc8+OUymkgE2nKEeJQpiD662
         Qn8FK7CGI3KHK5jxPev8GyR1oW/culVkdXnP2lCXlbGvrJuNG/Pnjw5St22+zKojF6EO
         ohvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707383455; x=1707988255;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SgZIIpOjpH8X4ZedBeUEAEFmQnSOxMry/KstJ3anrUk=;
        b=je+WIp2V/dl4nPsOksal3pplYQDvpfXX7/CZb6Lpo/BWlbcMR4+mjypVB9/N5rvKRl
         Ynx8oIfo1P8x9KeATOMYSG5lKPJjNR6yLsmCXRLYTpdYMroLwuIzzhi5EKzeTx7zshJ0
         pEYPY2entgzPT5I6V+VC8BfG13tgWbd7DUNbnNgbJWOFmelUnhkNFbHNH5APb9DZzfVK
         CN7NIdiO8dE8nYhxpNTzPbn35eKf0XjtUX8uJWWKtTAyd+0baapqxzXVfOWg5O7Du1Jh
         wXQEIuhYjD2TO6B9TClXBjvV1lKlD1zJwlURoKYSHPraaiPVb6Sh0yNv4FQ0JY4DB29y
         hu+Q==
X-Gm-Message-State: AOJu0YwfHP3u+5wZ7KRKpXxf1ddM22HTA7c6VrDRy3YrKb1GIsD8C3nx
	lW3DaN2F0rAAIvHJlr/r1xg/LvQtyZG2Z/GzPbGsqdh+AcDwsIpT
X-Google-Smtp-Source: AGHT+IFDt+UUWaOaPJ1DCE7JsYiVuPZdgaF1rku3f4EYnag2NkXFomFQshwpR5lBgFn0B2kmRwFfrw==
X-Received: by 2002:a17:906:e1a:b0:a36:5e34:3a34 with SMTP id l26-20020a1709060e1a00b00a365e343a34mr6110385eji.69.1707383455424;
        Thu, 08 Feb 2024 01:10:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX7/0x+jGVzXgiJHEN42juvnDeaSWfZibrtbcX1R540Tcct5jycehvYt85C7DVgv6keGKRJ0jm+Vprf6YPCEOQ+BS++wbVqCZYOqsuiIij6KkHYi0A1Svxqe/GjUg1pFrkaADOZAmc8DemfoM31p7mKqNZZ0hsT6QAL6QDeUdwpjWsfT/wV8hSjVtOS8+G16+xN2JNbMbnaQAWGrEFa
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:f81c:5b24:d269:24d])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090646c500b00a38535c6be0sm1691887ejs.16.2024.02.08.01.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:10:55 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/2] hardening: drop obsolete UBSAN_SANITIZE_ALL from config fragment
Date: Thu,  8 Feb 2024 10:10:44 +0100
Message-Id: <20240208091045.9219-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240208091045.9219-1-lukas.bulwahn@gmail.com>
References: <20240208091045.9219-1-lukas.bulwahn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 7a628f818499 ("ubsan: Remove CONFIG_UBSAN_SANITIZE_ALL") removes the
config UBSAN_SANITIZE_ALL, but one reference to that config is left in the
hardening.config fragment.

Drop this reference in hardening.config fragment.

Note that CONFIG_UBSAN is still enabled in the hardening.config fragment,
so the functionality when using this fragment remains the same.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 kernel/configs/hardening.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/configs/hardening.config b/kernel/configs/hardening.config
index 95a400f042b1..4dc0cd342ced 100644
--- a/kernel/configs/hardening.config
+++ b/kernel/configs/hardening.config
@@ -44,7 +44,6 @@ CONFIG_UBSAN_BOUNDS=y
 # CONFIG_UBSAN_BOOL
 # CONFIG_UBSAN_ENUM
 # CONFIG_UBSAN_ALIGNMENT
-CONFIG_UBSAN_SANITIZE_ALL=y
 
 # Linked list integrity checking.
 CONFIG_LIST_HARDENED=y
-- 
2.17.1


