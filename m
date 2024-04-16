Return-Path: <linux-kernel+bounces-147259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B05AE8A71A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3691F221E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2668112E1E8;
	Tue, 16 Apr 2024 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtU+x0LS"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2FA10A22;
	Tue, 16 Apr 2024 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713285979; cv=none; b=qlZcB421E6q3o45TTO2ApKgAvKLebewtjMESCQRykRRIKjIxVXntPQ4tl3njq6D0uwD3XfMZkkxOlWCs0KFic1YziYSbfPnvwg8zGs/G5DggEI3ZuuX6o8fl1YQkZlm3YRcPgNvNoBmPqtUNmd1kQ6iJyUmOUUa2CG1mDykooNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713285979; c=relaxed/simple;
	bh=G1/i1XTJcrVySOoFIsF/bsn1GVKpIRHZ/G7KdMBY+nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8ohShF7zgs7iAR4WvZSSaJ4P4Uw1kAh0RawV/4fl73laCkLCKbTMezmgJQSkVCx2PiexNNv8ZaoYr9LFj8BBp/bh+8Hi0L4UAP49sHv5wqoA23pg1FGdzjrufC8Z9TFWXUN1yzbMlA5FzyF1ZF4ln7h/W9Gw1EmpYCmkkbGvzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtU+x0LS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a450bedffdfso591772166b.3;
        Tue, 16 Apr 2024 09:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713285976; x=1713890776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8KwfYv9s9CNReFqGmEgJ8O6Pxz+KGqIgs20E/Gs/Yew=;
        b=mtU+x0LSQ2YlturUymwXYZnzX12e382XIr8VB7hDBLFGJ9RR4uQhpDX6HvGnarLJWt
         NJhJkJaknNcRU0sEpL91rvauchWgpndCGbIqOI2rt6iAzKMDG/EToGzDCgIjSw9MCsNu
         aCNbB7WYUiGQE88JQNKH6udtBAZounM8YL6Zj8JsG3DSReNN01BnYSkkP8L8w9z3cSS3
         huV4fSsJSwWSF0FFjtjV+jSoVgMjBVe6TpfeQRVT3iXHRu5Qr64B0ALz7531EOBbfiKv
         3Jg5FzTJNXwxYkNGVQp/k4EFEbFJX32OeMrveMzfiHfvplNLwUBKmJonmjAe8ml+Ffno
         /WwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713285976; x=1713890776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KwfYv9s9CNReFqGmEgJ8O6Pxz+KGqIgs20E/Gs/Yew=;
        b=v2jgXz4dfqYD9zWMNuM3E60NZB+dEjbRqtvvfNAYXHDYxjWz3FUrg7Pqf6uENRXyxQ
         MsAuvHAJhtPH/tcCHiv3AzGI3PZX6cxJmtpIUwgypwMGxSqdVtfrkO9JgUnPn5Ko2yy+
         7VRCHIZKFqiveP0Xr2OtIjorOI1kCWUaC8bND/GLV7DCeOs3VG2rHu79A78KVMp3O1jr
         KlyaIOjZ2WBQLtDQS0jwGGRlM/3IBzMCsETGYoW/2Za1pZQyalBGJ4d/vpi5EnLJ+mul
         GSN/r5O/QyT8PAb/7cxIWe6xsxYYWNNi1j64GUpm18vKATbz27+KRPf5+mw7Jk92HXPb
         GigA==
X-Forwarded-Encrypted: i=1; AJvYcCVy2kJRCXElA9LeopH216fPq1stnNDWk8k3DXYRioent40dg03Bvdz9a0vwPND3dxS3klOWQRFzu5ETJWzTnUA1nSYMQTisO4Kof71x3LzYWV7XPwF4gXw0R+frMqvFUmqzek5CffCt43ko5QQExYYwxaJy7eZ5h6OgyYed+TCA
X-Gm-Message-State: AOJu0YyHWNjrqaGe1Ug5aqdlmV8Tfu+e9bya3aV9MG+218UutCwHY4Rw
	vQ7m4TAw9bbj9ZylHM3u3HVv5g8Go/0m7VjZ1Lv0cj7RsoejMudDFT3Uox6W
X-Google-Smtp-Source: AGHT+IGRIiQlbaJp1thbJmdm9VDlSSbedhwFf3PAEq68sJsXPkTF8SCv5gGIXIt4Wg4rMB/S33hAZA==
X-Received: by 2002:a17:906:af8b:b0:a51:8d60:215a with SMTP id mj11-20020a170906af8b00b00a518d60215amr8125981ejb.27.1713285975999;
        Tue, 16 Apr 2024 09:46:15 -0700 (PDT)
Received: from fedora (host-79-27-41-113.retail.telecomitalia.it. [79.27.41.113])
        by smtp.gmail.com with ESMTPSA id bw26-20020a170906c1da00b00a52222f2b21sm6919666ejb.66.2024.04.16.09.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:46:15 -0700 (PDT)
Date: Tue, 16 Apr 2024 18:46:13 +0200
From: Francesco Valla <valla.francesco@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Linux CAN <linux-can@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Simon Horman <horms@kernel.org>, fabio@redaril.me,
	Mao Zhu <zhumao001@208suo.com>, Xiang wangx <wangxiang@cdjrlc.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>
Subject: Re: [PATCH v2 1/1] Documentation: networking: document ISO
 15765-2:2016
Message-ID: <Zh6rVbkheAcS-K3D@fedora>
References: <20240329133458.323041-2-valla.francesco@gmail.com>
 <20240329133458.323041-3-valla.francesco@gmail.com>
 <Zhyabya8UyRG0ZY5@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zhyabya8UyRG0ZY5@archie.me>

On Mon, Apr 15, 2024 at 10:09:35AM +0700, Bagas Sanjaya wrote:

(...)

> 
> Other than the ongoing review comments, the doc LGTM (no htmldocs warnings).
> Thanks!
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 

Thank you!

Best regards,
Francesco Valla


