Return-Path: <linux-kernel+bounces-149732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B718A9529
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C51B1F2231B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0771586C0;
	Thu, 18 Apr 2024 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOWOp2cl"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9E11E489
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429616; cv=none; b=lho2Vx6LUSFzjbsXhB1mGNrkowdYmhh7iABWRIgWmxxRFHme55ei9GQzogxDKVqLee9YVa9KN4XlD1By5Ql8GgdYqGlcKr1WRQRO/pRqXC2d3DDW1jyJ0+Esk5sISdi5zTARoQYO3jGWtAmnRGiVvJlqmiUrKct/Ew6ELCVaOus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429616; c=relaxed/simple;
	bh=2yLR9iE2LkhbTFYfU2TN/WL6XVZjfvkOelxFDiCfsO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kQyndUR1k+v+673KU9HUjz7Vo9r0kY4wY+HOgurXLs6N/NJ8J9z1PLUPAv9zzF/U5Ir/J6muqxDdrCfXAkgzEjwtasXfzj6RGLBqGLV4W5Eejtl7IVxVEOH8JwaNcl8SdExeZlKLtXXAOuJhqeTovkzq4k0q0V73ea+JT0EJnxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOWOp2cl; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f074520c8cso619124b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713429615; x=1714034415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yLR9iE2LkhbTFYfU2TN/WL6XVZjfvkOelxFDiCfsO8=;
        b=SOWOp2clbHLYLZTQ9TfvNtjr8jw6/A/7F59wDKOwYm6f6y5UPXYzKBz8zm8KCmoImW
         5DYGw0XIbwZsqOhm7Qg2TpZVgQATUpf6WsPR5zz75Ud7U674XDT1Sa/UyADjTWrNKWUD
         OBPUdxMccRacb0e+tX42/XpfAHkLXJVzm5/Wdz0r3fTqXQC6s8DL0cPPsPQtJ7fr2TJM
         rRnRuIEa9hlR0SQoASrbSXXBjfOUCOAwZSifnqYiEU+yk3f6Qt9T8KAwZcOgHdo9xs3f
         xQgj4TjBZzSW0BF2wEP7wwKgZ0o5nxFt9fd4YGBZkpyOgiTjmdlz3QhSQR9hTVxRbOsT
         75mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713429615; x=1714034415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yLR9iE2LkhbTFYfU2TN/WL6XVZjfvkOelxFDiCfsO8=;
        b=xNkuqEDpsMT0cSMLIvHmiGY0eB9Tlc++6Z8w0+ji/DxETOaw9uOY2uH5Z+gc34FhTw
         PqV0Ah///k//VzDwFynYOb/MYmP/rkOCV+7loLMqbWZ5FPcJQU+FT5bizPdup3JG749g
         n//LJe3kQqax4QFwLGwtr86PnRdqSV+2NNd6SpTpcRh5RUujmMl+iadzjNTP+JRt9J03
         nlqEdwDv6uU5IwKJQ+oQoe2YDzIC8ZkRnLGwgb7aA87IFzrP6TNC6JDdkBvSUabszQAb
         OnpEtBELS+B4vt3aLLP8Wbq9oS+HBNY4Q57IJT1flCKSDW3iwDSUw6XC7rGNK2zHP3nR
         exDQ==
X-Gm-Message-State: AOJu0YzpFe41vLelOkWqdGwYYNdkPLHXIyxGciHdAZWctl/KRzsR1r/H
	c2iTCMBzOrN/EKa3PZRc6n+TmgejGraPRcLHPELTnOizwgL7rfnO
X-Google-Smtp-Source: AGHT+IF/9a9hJcTLiQZ9mcGVsae5ad2hLAqR1OWnQVxs196eYM5Qh8idzc3qDVqyOB85VrDgXbKL6A==
X-Received: by 2002:a05:6a20:de89:b0:1a9:c3ac:c6d4 with SMTP id la9-20020a056a20de8900b001a9c3acc6d4mr2091140pzb.62.1713429614720;
        Thu, 18 Apr 2024 01:40:14 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id j18-20020a62e912000000b006e681769ee0sm996078pfh.145.2024.04.18.01.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 01:40:14 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (3)
Date: Thu, 18 Apr 2024 17:40:11 +0900
Message-Id: <20240418084011.313378-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000004a86bf0616571fc7@google.com>
References: <0000000000004a86bf0616571fc7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uninit-value in hsr_get_node

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

