Return-Path: <linux-kernel+bounces-20226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBE6827C34
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A681284E6D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B26ECE;
	Tue,  9 Jan 2024 00:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HfR0Fdoj"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00370A20
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 00:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2a360dbc11so209522666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 16:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704761197; x=1705365997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aoR3d7LfgTmoM/CHxGgDDDxlyBVoYcCJKpBiMdoon+E=;
        b=HfR0Fdojy7JgmNPhcYtLUUUl314WUCI6jPyRt85U0bRqNOodBovS2n2IjOAdtSyhWy
         8SbYF6JU+vtM6mAgznpqb08LoM9ZBnttgFrjKxLV2iCrmfJAZd5T1uarL2AL3Iq6h+GJ
         69P5K6oJgTly9lmrZvDl/QFs30tYLa0aiNU00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704761197; x=1705365997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aoR3d7LfgTmoM/CHxGgDDDxlyBVoYcCJKpBiMdoon+E=;
        b=Qm/sdOonfZF+JFBSYtP4rY3nV2i+VyEg1SdRY/W+CmSrEP2VBVn6EDtj2mC3jahfXO
         H9bP4jW2pt1aFsAmWk/8gtjqWBX7EUnO+kH4U71uCqZP98caNbxJTnwop6MOcgX4MPSL
         3qOMqMGdwjV8YUTYaqT0S9L/iDcY/UpcOgr2vNMbUIXJLAd3fxYUAiAHUIku7M0Hh3E9
         lcLHWWYBfHBQnc0tZcYdSGW2q7XSvkewA8uJhUYWNvEzSxfl2PGcqG8sujmJM3x+mNIF
         0HLIhbGzMGVPprFy4mT55jDXP8Hpw1l+/10mHW5XHqkrbPyhjIJ5Ti62BT6H7mth4ufI
         R6UQ==
X-Gm-Message-State: AOJu0YzSFGyXeMpkaVYxXm9F/5zIi6Tpvv+VgqU2n6qcTzq0FYIN1ew6
	92T28eZN3mcgkkCF6QgrNpJiHhzlZrOsvX1lRk1B13gnl3CZJ0UQ
X-Google-Smtp-Source: AGHT+IHwANuchL9dBZwlasFNUHIfq4X1GrPKy65rnTPohEuQp+TLEaGGQkQx9/4J1PpxAUhKcnfcdA==
X-Received: by 2002:a17:906:e293:b0:a28:a806:2144 with SMTP id gg19-20020a170906e29300b00a28a8062144mr111398ejb.110.1704761196881;
        Mon, 08 Jan 2024 16:46:36 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a27-20020a1709062b1b00b00a28ee0680d1sm410722ejg.214.2024.01.08.16.46.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 16:46:36 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5574feb7958so2696540a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 16:46:35 -0800 (PST)
X-Received: by 2002:a17:907:6d1c:b0:a2a:92ae:4cd8 with SMTP id
 sa28-20020a1709076d1c00b00a2a92ae4cd8mr157223ejc.120.1704761195643; Mon, 08
 Jan 2024 16:46:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401081028.0E908F9E0A@keescook> <CAHk-=wgznerM-xs+x+krDfE7eVBiy_HOam35rbsFMMOwvYuEKQ@mail.gmail.com>
 <CAHk-=whF-ur-8B5_8xgm0h9_=yX_Rz0Owjo4ghRwYVnKr-3z5Q@mail.gmail.com>
In-Reply-To: <CAHk-=whF-ur-8B5_8xgm0h9_=yX_Rz0Owjo4ghRwYVnKr-3z5Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Jan 2024 16:46:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=whkGpqm4oFkgJdgcUR=K3derFimUGa+TDf97BtWMcrxYg@mail.gmail.com>
Message-ID: <CAHk-=whkGpqm4oFkgJdgcUR=K3derFimUGa+TDf97BtWMcrxYg@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.8-rc1
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, 
	Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jan 2024 at 16:30, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Again - note the "might". Somebody needs to actually test it.  I may
> try to do that in between pulls.

It boots. It builds a kernel. It must be perfect.

             Linus

