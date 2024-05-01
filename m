Return-Path: <linux-kernel+bounces-164925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E1D8B8503
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66132B22B08
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C1D3BBCC;
	Wed,  1 May 2024 04:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWXlYc1r"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B782572;
	Wed,  1 May 2024 04:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714537873; cv=none; b=b0ZV/8XPSSeX8BY/OxWp493FTu4mp0psXI0I/mOl9bNM5avh6QAdgLyh34XAD+xg9963gIyoG69E7mQv/QZQRGOwj8eFiTroUZ7UZhg/4ebW7Jbg2a6lKX94NoyRuKISBj8KtmNps0lRy74Jtuc7ViWTRUmOtPD2Nlm+KwlLOxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714537873; c=relaxed/simple;
	bh=ehtlKgUoW2wMkIdQbSn6yZOg4NRiq5q4R0ZqTQom8Y4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=k2G57g9cJtPsqsEUaUH14lGNMMOSIgUNVkqxR4+16n/APc+/BPjw66nbf4kcr7WyHi2b62l8OOFgX6uCiMa8XgoU3VlMUmW8uzTMViJCkE6NdmT99f/GMeCR7Xi7Z0lvMZaGcQRQvp4qaDaRX9O/gAe3RuLvVpkQCJ8C4SLkT4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWXlYc1r; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f0b9f943cbso5259581b3a.0;
        Tue, 30 Apr 2024 21:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714537872; x=1715142672; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ehtlKgUoW2wMkIdQbSn6yZOg4NRiq5q4R0ZqTQom8Y4=;
        b=SWXlYc1ryY5wEvUW62/+r13niO0VUNQq5V2fPu3wX+Mcu6JDhi5FcI5YK9o0+z5x7L
         /yOIHMbncHhlZNIBu0wc2A3fjF5DyCg/B+4X4tmYE1abciqkmerOojbKadvxsMALOxjq
         8p/6tbYNRBWc8HPubS8lzNn9ZJatDs37GVTwQ+XfBVkxmA1hCP7ipe+g9HM1S68qdaKN
         Rky2d9fWJlupOVZZjV3dJlMuGUaNXanc67zbxFE9h1ab3JZs1JRJKY1cfilU6SYbWsPc
         6BuFt/WNXoTPYYH/NgRVyCurN9Ku6tQIyet1dJ8DsS4HlCgApBr1bDwNWCH1xymjrs18
         e6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714537872; x=1715142672;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ehtlKgUoW2wMkIdQbSn6yZOg4NRiq5q4R0ZqTQom8Y4=;
        b=c70oWwmouLsvLCMPVc7seThZrYVn2nHr86RLPat0COsFcsAS1duIc70xaBAJAJw58F
         4gUcdNueHe0u5mzKy3yhh2gu24Z1RGBffE2Vu1TWFsYy5hA5xNJYuHjl45RttuM/JAGB
         ZGqaoT1woImw6DZVxAu0YJAYC2t6KFO1iqd8EDWi7I6cVvbKPpWSu1j/tbYuTYgdexxA
         VYsQkjtysaM4O844ciojwjHA1XanzITkJCDOOOMJOn0bMmK2UxbJ43zkZy7zmtY8kEe0
         d4XOawtR1wAYGjZAiECj+JfmldZaD6f9BymO4/KXRnwS97CexaZ2OqwvrEoI5Gsd6yC0
         i6Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVjB85NDn9sIAkhdXHw9pG4itRsjo22HTd32HJHEtDH3nPoV+StB+iDMQLKga82RSgwxQOgi0i/Rs6dTIeT5fnwA6Wfm4K8TQnNYQd55PdqiJ2F8QRVDfwp7dVpHMuy0KVjKz8gCn10MYJjV7PSgOTzBTsXT2DbjU6z/06DUWGiU9gFGeOImA==
X-Gm-Message-State: AOJu0Yxb5DE52m3HhRNRK1BZvN+XiZDIRSrcGeTp5aYQ1UWZHFTs8gh0
	sgclW+zjreiDG6W9SqZVlMzLObavl/s5NJ9eRHyKD2yyXXtNgwvTp+sXLyNvdClvsE1L7pay6ff
	YiiMvuDDPBX5YkxtrZMdHht6pdUI=
X-Google-Smtp-Source: AGHT+IF1S+z589TJNkRFleq3ZlYQTlbiZ8DyCgYD0YriYJog/J956Bm/0/tLqzT9TTV754T6OCSvrlxbQELm9a2NVVw=
X-Received: by 2002:a05:6a20:d491:b0:1aa:6178:345 with SMTP id
 im17-20020a056a20d49100b001aa61780345mr2108072pzb.7.1714537871593; Tue, 30
 Apr 2024 21:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shresth Prasad <shresthprasad7@gmail.com>
Date: Wed, 1 May 2024 10:01:00 +0530
Message-ID: <CAE8VWi+UwYWw+RBMPi5ozg+sQHKtyxp2i2K3u9e3b42Gt8D+qw@mail.gmail.com>
Subject: Re: [PATCH][next] tty: sunsu: Simplify device_node cleanup by using __free
To: gregkh@linuxfoundation.org, davem@davemloft.net, jirislaby@kernel.org, 
	linux-serial@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Julia Lawall <julia.lawall@inria.fr>, 
	Shuah Khan <skhan@linuxfoundation.org>, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shresth Prasad <shresthprasad7@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

Could I please get some feedback for this patch?

Regards,
Shresth

