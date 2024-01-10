Return-Path: <linux-kernel+bounces-21759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F26B8293D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962BD1C2564B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3813638F84;
	Wed, 10 Jan 2024 06:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K6oVFJzY"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F358A38DE0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ccbc328744so44605091fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 22:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704869637; x=1705474437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cXgNlQp1ZIJ0/l4IwMaa4BquknnSQdylTP1plQb4Z60=;
        b=K6oVFJzYZ2wtfKTO3YsG2T9WJy+Rb3PlTe8VnWqgtHpyBfdltd9uiZq++FuTDbY8qE
         Zld/tBeLhdT//qxiEfytmUie82qNv7gvbdzJnrE1cGVEr0voy4IxOklMH+YfyW/qsOom
         3HxTstdP1LR+QYNhzRMSD5HXQxLYcu66ju0sTTBXV6ACxAB8m45HURUecijNuE4qes+7
         4P5qIO8Zy0ns4oxMCdo0eujZl8pu6EDd4uJLmmAcJBCR53JrZxkz3/6iw7vbfHlIw7/V
         Qow8x4x+KVyzkOH+F9CKUqdy7HpICyzhe4lPD5fDQuCJY/lub9410iUFNtwPfYXmnMvJ
         vRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704869637; x=1705474437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXgNlQp1ZIJ0/l4IwMaa4BquknnSQdylTP1plQb4Z60=;
        b=DlZ0I+JGcVp+u2J7cDHJCnu9uxTpHd1nBHKLJ6xGqQd70pL88LHdaXRCOArGYPIk3I
         v0wfASFi2UuaUgxb+0uLf4rAVdYME54/WPpTBT+GxIKwyizX2zJVakGKdMEFApq4RfQH
         K4gNt/JdCY+/NNHQhxZiuMhVn/FM4TLAuY4LcePmtBXt4fhS8SwyQjhtzXqBksyca5kW
         C836dOwt4EwPbxhCT1V1naMPHTkU7+hluGZJKo6USJVYKAZ87sY8uvNQP4SEpBNXeaK4
         9hr8WlQ2IMyDnoJSN9HNPdUzUrYH5SNprqaBRaUIpQDzbqtl5HO6R3eK95bHTkmbGBO0
         bO/A==
X-Gm-Message-State: AOJu0YwcQSltjox5rcGOj81gtWXMR9KE+V5XflJeTeiA80hUuuVFKGIq
	vHRfdqJ3wfC5SHEWTxqIpaKDX4qNMngWHQ==
X-Google-Smtp-Source: AGHT+IF3j3cmVNgId6d1lExluxTZGmz8RXnmQQAxuo9PbY8mP3MWYu4i1ZwCwl4JIDJ5sjQl5lo/Bw==
X-Received: by 2002:a2e:a22c:0:b0:2cd:36ff:4d7e with SMTP id i12-20020a2ea22c000000b002cd36ff4d7emr231300ljm.21.1704869636986;
        Tue, 09 Jan 2024 22:53:56 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id s15-20020a5d424f000000b0033743c2d17dsm4093929wrr.28.2024.01.09.22.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 22:53:56 -0800 (PST)
Date: Wed, 10 Jan 2024 09:53:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthias Yee <mgyee9@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6655: fix open parentheses alignment
Message-ID: <0efd34ef-1543-448d-a690-64e156607441@moroto.mountain>
References: <20240109205933.3221-1-mgyee9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109205933.3221-1-mgyee9@gmail.com>

On Tue, Jan 09, 2024 at 12:59:34PM -0800, Matthias Yee wrote:
> Adjusted whitespace to fix checkpatch warning Alignment Should Match Open Parenthesis.
> 
> Signed-off-by: Matthias Yee <mgyee9@gmail.com>
> ---
> Changes in v2:
> - line wrapped commit message

Nope.  It's still 86 characters.

regards,
dan carpenter


