Return-Path: <linux-kernel+bounces-146037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490A38A5F40
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A83E0B21753
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE48C81F;
	Tue, 16 Apr 2024 00:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTj2+TkF"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0358386
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713227366; cv=none; b=nWL1sA4CyRnv2MUfeEGqgVhKbRSvDux6ZdHbQXogPpXK2drXvlxMu+jHLTdm/ZqM0qtzFNNP+BDsk1cytCNxJV/Itfu3x0F5apVRXJeY5rvqzlr+lzrFCEIEuC+uFsoV0+ORBpI5obaA9QVNqpAXCf2pzaFyjtQH+UEBf/SwTuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713227366; c=relaxed/simple;
	bh=Yf1gUr1tvKmKsM1pOVHTcwnl8aKHEskvwPqkV6rEw7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRhyttG/oXXPmhaybLj6U4yS9liNhOgzvbjZAhkf7GrmWcwbgETqKr8JbzPiyb543Y+esG2idDBiwegWxkgHZA5gDsGi7v7hPVoUaONyjjlK413BMQPBFo6u1odm4tA68oNlmqyRkmJxIRJyA4G46r5twA1nKnR3+syusqaRvGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTj2+TkF; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-69b514d3cf4so32801026d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713227364; x=1713832164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yf1gUr1tvKmKsM1pOVHTcwnl8aKHEskvwPqkV6rEw7A=;
        b=hTj2+TkFD6CPsP8ZKVu1z6bJ0mdCGSgR7+fCCMzNz7am4UXZsXPwoqo2OFZrZQQP7k
         AnOCTcfxIP/Fu0js3+YzS9dL2mWMfbi5Ga6Peb6VS6b8Sgvz2xZ1Duw7LJ/CoyWJueB3
         ZPNxeDhM9AVMjcTO98Bq30kN8gV/R8+Lqg9u78icJmdOk4EcssNJJivwbsOD/Sdu3TH1
         2Qxp1GDx51gn8PUhnMYHl1RzpEOZXAt3CKVx1WvlESzm6u+ohRu2G1LL96Xq7Gv3T9yU
         3bsd2mMa4FNI+FlufTJ9w+MUhc7dQuu5IeJgiwhC4YFoFqFadyxoWk+jxHx5nmo48EuZ
         47eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713227364; x=1713832164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yf1gUr1tvKmKsM1pOVHTcwnl8aKHEskvwPqkV6rEw7A=;
        b=s2X3+UHmf+yEjBpPHcE6GJFP5vxlkMotL1Ya7cuavYUvrPTtf6smIxxRyij3Ic/cGi
         VUT4T+MUlSxh+2vqkXoTErzmTHYu5z8zlGuswgyaeLuCzlkAm2QUsX7U5p+Vpy18feQt
         eq3ZhF2Dbu/YLyKdECIlLMuiyOLtViSCTTrdlhcuHTxZl0KcpBr/jkbNjyen8u0c+YrN
         TZBGHw1fn1w9LI1cZ6ewCigOqOfq9tv9DIU0k8oq8HCBimTC99hn0Wz3r1yvuXbv7h/C
         /td5HdYMe2qM6kQJ5rLdnmM9JnL444vhrGW2Fkbyri3Ank220Er9jD0XxQ6HkdkrZtjI
         8pLw==
X-Forwarded-Encrypted: i=1; AJvYcCX3WfpZvhBBrgGKHb1pZMiR7fPno5u8p5lNarLFMh66ygvoGH7DYdRarLB9M0yh8IqPoTcXuM+WCC4VOlyR+FaIMnIgu2JLuV/D/ICd
X-Gm-Message-State: AOJu0YxvZj4oTAzrPwY4OgvoxlVCAboV+bwUiuefwt32d8a7ghvCmEtQ
	f3oudYONMuI9KNQwPv1j7BfXC2sejJIK8RWCyXgNNPCUoxZpY1OO6yPK/h9QgeljoWhu9eYH7CK
	WY3zZRC/VCMKzoJlK/6t6BfOqh+o=
X-Google-Smtp-Source: AGHT+IFprmh+7vT78kNblQOtapK06gC/CQ9a7Zl18oKXuT/I8ULx3XNzmCJY5UzBGVmcdWWmKctXD7+TkZTWYk1wx8g=
X-Received: by 2002:a0c:e944:0:b0:69b:7a52:a894 with SMTP id
 n4-20020a0ce944000000b0069b7a52a894mr5297027qvo.46.1713227363836; Mon, 15 Apr
 2024 17:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240413022407.785696-1-yosryahmed@google.com> <20240413022407.785696-3-yosryahmed@google.com>
In-Reply-To: <20240413022407.785696-3-yosryahmed@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 15 Apr 2024 17:29:12 -0700
Message-ID: <CAKEwX=MXKTWzCxPLy8VtdUxM8JFSpX4cR9agMDVtta_O-ZXFVQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm: zswap: refactor limit checking from zswap_store()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Dan Streetman <ddstreet@ieee.org>, Vitaly Wool <vitaly.wool@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 7:24=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Refactor limit and acceptance threshold checking outside of
> zswap_store(). This code will be moved around in a following patch, so
> it would be cleaner to move a function call around.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

LGTM!
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

