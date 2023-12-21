Return-Path: <linux-kernel+bounces-9153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2053E81C1A4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9CE1C24EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC2079475;
	Thu, 21 Dec 2023 23:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvjjT3V4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C480378E9C;
	Thu, 21 Dec 2023 23:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-67ac0ef6bb8so6484276d6.1;
        Thu, 21 Dec 2023 15:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703200365; x=1703805165; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RwWjnQ9Plt1oqDMzGG0AXj2S4ylf5A0WSUb1d1LBEOk=;
        b=gvjjT3V45phMaW0h+RLLx8XWYG89gZXO4kq/Oskclm2ziRyeZW6y4p1CKfAswn/9zG
         J3gkN49FnYbHQWI1cdg2GtBcT0LRQ/gGXfI61Ozf9W+rAUdlN8ZGPJHBy5Z752H1sKxC
         AWUjMfU1zuTjF/3QANlNJPm42h4QgK8JfBUXK0p7B39l/zI7AnlAQRQ4mTHso7u8QtPS
         vxC8tWq3ViiXgP1FraEiFtFr0s+Jz7bNEuBXAdVz6zy3gmCgnW+EpRVpqt7d+fokj8se
         Lo2n1TohuZGOCnQ6i3bBNbzHIwgbU5ClrL8B2ZbZwuGMwrHLFnlHxaI2UEyWVvoGQbGR
         eMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703200365; x=1703805165;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RwWjnQ9Plt1oqDMzGG0AXj2S4ylf5A0WSUb1d1LBEOk=;
        b=CKqqjj0j9iLiYvYJs2/YaS2orsjoumwsiZnKDzPMNly1YR1E8VqRrV5kIig51zpOa9
         srKBU0JnlhbLWvf113ngDd6L63Mc5MK2M1rkFtyF6hQL0mlPltcjvEpJdiGTOVPFl9Cw
         5t437H+QkuJmmTut9uGa0Mo/tAzgWoWlwo33dRPWy87DMuiE563g/6Mfsocdwf0M21s9
         lFeh8OfkM22jJCCu8fByU7cFDvC1CH2ro6amGHy5jMXL02EjXorXx+t6PJTnu8B5VQZ4
         CrfnD+dV1M055xmpQbNoaKvjXUGKu+eY+HvD/OYt3gs4wTeguIxKxfKwatbxNHPjiqSH
         88Ow==
X-Gm-Message-State: AOJu0YxbE28hwmGlLHJVQzoc7kj6jvyu7cR1UxYxEwtZIbBkmdyVV6Pg
	QunoufsmS0eA5DQFgxa59ga/Ii0q7ctMRxOTllMiaiHI8CA=
X-Google-Smtp-Source: AGHT+IGVES8qh/TPwb94zIco8hdLk9Dx59bNisGk1U6h9zaT/VmDbCugA55FQSwFVZTKNMgF2oR7qu+zZ5ZSN9tuA8M=
X-Received: by 2002:a05:6214:ac5:b0:67a:cd6a:754c with SMTP id
 g5-20020a0562140ac500b0067acd6a754cmr717679qvi.33.1703200365383; Thu, 21 Dec
 2023 15:12:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Rankin <rankincj@gmail.com>
Date: Thu, 21 Dec 2023 23:12:34 +0000
Message-ID: <CAK2bqVKCdaD6-PZi6gXhf=9CiKGhxQM_UHyKV_onzDPnhbAmvw@mail.gmail.com>
Subject: Does Linux still support UP?
To: LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I have an ancient i586 UP machine that happily runs vanilla Linux
6.4.16, but which locks up shortly after booting vanilla 6.5.0. The
kernel *seems* to run into trouble as soon as the networking layer
becomes busy. However, its SysRq-S/U/B sequence still seems to work as
expected and so obviously *something* is still responding somewhere.

This problem still exists in vanilla 6.6.8.

FWIW I have raised this bug in bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=218296

Thanks for any help here,
Cheers,
Chris

