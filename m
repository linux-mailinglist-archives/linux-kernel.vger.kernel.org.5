Return-Path: <linux-kernel+bounces-6251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1307481965C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D98F1F26468
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F94E16434;
	Wed, 20 Dec 2023 01:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nj9gV0Gk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E94E15AD8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 01:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbcda1ff95bso5255370276.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703035988; x=1703640788; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcGd8hD1GYbqQmtxD4XTvkSxSTm1ofoM7OB/U5l8jC8=;
        b=Nj9gV0Gkk6u0HlWrCw2WAqf53As6cdNvKK9QC2tRxqRr6YeWYEZ+FQdhoo8dllnt9A
         Kk8S9Vwduxji4nm4z5ziLDDyJ/4hbZrfoV7FSykNijy/jRGzg1DCAHJ+LafIyg8agIYq
         s8epWnTF2+sFVaOKKWXD5OLj40dciuh9cwyiPnm5JG2JcEFsioN57r871CHDWVI0XZ6R
         cemE/A8OWK1UE9njRG8DCYOriNEq/58X4WXzv3ONXxQk1behsJKPGoy8BzDtzy7wiofF
         DYJNQhVho4HzXFDjRbhvqtAoT9FCabkFssi3zyI1FfQjwerBHGzFJRPto2JaPB0E9CHo
         iXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703035988; x=1703640788;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcGd8hD1GYbqQmtxD4XTvkSxSTm1ofoM7OB/U5l8jC8=;
        b=ssH27UxjfIpvGDFB13N+MtOF/ETX6AUrBpbFOjG2wOURrEx1Tf12L7CQBswENTr3bN
         zozcaARyn2twtZas8qtFUuulPhs96zKVJ7pRLxcqZaUJF+EqtDkhx/Lm9RMs2w62qorI
         9yE0x6OkD/1QWM+DK8ZSutRXtfMZolKBKEQiP506Roj7UW9lzFOikv7wtgcjaxbkVpeW
         bWksDtJgZ1n1o/XJCKEiCc+IANN93OlV1TOZtBdzGjcGOWaiMnA/gB9hfRA1p1K8M1eW
         oku1+eM/wRiTyzOZPdRh0JppdInOvyb7pNDXH8thEUB2zh6dqppI00BpqCIK4LtRo+nJ
         uK2w==
X-Gm-Message-State: AOJu0YyhA4TXspfo4U0ouZR99qOE3vA9XlkmFOyRMhtz5pidE3IcW15/
	QJ3Gl3xp08lYlaMGIQ3W8+qDEajGrtI=
X-Google-Smtp-Source: AGHT+IEzH9EZ2sFvwVybtmtJ9FVuhULztY3h62x7Clm5WLnKWnsW8X46WotbUtagjsVDGqhXc5VyhdfSdk8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1364:b0:dbc:ef63:f134 with SMTP id
 bt4-20020a056902136400b00dbcef63f134mr2647919ybb.2.1703035988775; Tue, 19 Dec
 2023 17:33:08 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 19 Dec 2023 17:33:06 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220013306.2300650-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2023.12.20 - CANCELED
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

PUCK is officially canceled for tomorrow, see y'all next year!

