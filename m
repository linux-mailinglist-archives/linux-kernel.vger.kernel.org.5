Return-Path: <linux-kernel+bounces-101045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BDD87A178
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742C9281ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2529BE7F;
	Wed, 13 Mar 2024 02:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0px4e3K"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C991D8BE0;
	Wed, 13 Mar 2024 02:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710295948; cv=none; b=nOnbfau8m6nux3GfarQ89i1Ul3nwjz+udjlhdYlzfNLu3C7PtQcHc6+c68/7GSKA2Zt02myFX3OMLiwcMxJmgGfIcfpOuJNnIuvNHX99jmVvQC1LW/Ph4BXAYdVbJQ8fSJBt5x9m9K1H3CX5GlZwmlt9XdizasRo+g+GnQcEi9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710295948; c=relaxed/simple;
	bh=OxZeUSklJ1E/J50SJe/b6JddmKvOlBeFQcASpgcUUNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=scFMYZCagFQf1BIpcEnUWeBVN7Psj3d81yuhgGIeIPTKhXE5HCv2IQoEFkWBiwLx+cneW/ibYqRzwPj9t7W7xUO+lLTPcW7rnfLXtc9YQspAAmlZqAtu0fZZKj8KcO0ie1Li1CVk1KZ9PTF4+HtNumdEYaqnFHNMhh7QohaSEQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0px4e3K; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dd878da011so21552025ad.2;
        Tue, 12 Mar 2024 19:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710295946; x=1710900746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9COkBOs2/quH6H55ozVZeiELoH5CPndboJSwRuo65/E=;
        b=h0px4e3KkwGpzqgL7eeBFwlBNZW9sJJT9aLPCaaDvhlJzDDouNiDgwv8xaKOdsVlMA
         tRLpc5NQO3s0XT+5ZwOlXN8HPlNBFY9oANAK7bmVoN0TY33em3oLA6Eb+ZuVczmIMYEr
         9wVoeJ5C9baevUBWwxp+4Ci3OYHCT01oBgVGp5patPpROuHw4OC2mA+dL/4In5Ft/jGW
         xxwUJ+WwkdR9jv6rnt8zF3o5TBI6x/fl03lrOhOMgqBi8Z7faHo2/C1wouGkHodPX44w
         PzpLWOhUV0mPkp2zUjy18XO+1ipkQQE40JqjCfWgBUxiVaRH0J2IB1qJb5v8jE1xZjLF
         MQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710295946; x=1710900746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9COkBOs2/quH6H55ozVZeiELoH5CPndboJSwRuo65/E=;
        b=W5hW8mfEuDmS3RoCRyAOjVKYuBYkhJUr4ALu9bnzrwgpCmQeb5ccToTekodY/jTTsx
         GaFv3e8MVNVQne6G0VU0R18HadtH1I//j0xfhD7THRKqmUA3/NhP7Tl4zCbIaHFa8MHf
         wnQHY8TJZWzQURWhOAHJ3A43aBq4C/c+VIxkHgM8mjrGQYXUXV0zFqj2KvHjWslIhArN
         7TzdPclhSaYwq9hk2H9kA+nt1xrsgM1/zJz9O8hq4NamTfQjFSKkRX9cplEfqkAn/YNY
         /e4qbyqHnpHfZ6o8WiFMQrielH9QPgv9cbDXHRlWERypB2B8YmUOZjz16QREGD1AOvQg
         kFqA==
X-Forwarded-Encrypted: i=1; AJvYcCXf3zfFIVDdhDXbrewQ30VzkV7d8gcbJrsF/toJca1Kn4ugWUtPdoCsoPU520MMTCrUrzedLN7m0lO+9ZBHeAUH5cr3WjzW1fvl5WBhshrc58xT1I7uK2wxpmv/RCT7IwZLU0hDqnxoQ5OMC3732mYyzkgR2EpV9RyKqmU3qePA7ji5JJUWhw==
X-Gm-Message-State: AOJu0YxGSdiphJDQ2QyeVUixKCHw938UkfixFE99zGpbxSR2W0yQofPW
	AHUIG1qa5nkl0uul/GQ542oHcdOUw4fP+DziPsnkhS/oEyNT1GfD
X-Google-Smtp-Source: AGHT+IG9B9d6ZTX1q+dCnXzRa7iyvVaRX75NwRVPKejH6e1JM0uiHX2tM38AXnF7fIWdLaM0xJYjEw==
X-Received: by 2002:a17:902:7ed0:b0:1dc:de65:623b with SMTP id p16-20020a1709027ed000b001dcde65623bmr2836623plb.60.1710295946099;
        Tue, 12 Mar 2024 19:12:26 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id b11-20020a170903228b00b001da15580ca8sm7368881plh.52.2024.03.12.19.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 19:12:25 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: ebiggers@kernel.org
Cc: akpm@linux-foundation.org,
	herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org,
	sfr@canb.auug.org.au,
	v-songbaohua@oppo.com
Subject: Re: linux-next: build failure after merge of the crypto tree
Date: Wed, 13 Mar 2024 15:12:11 +1300
Message-Id: <20240313021211.47293-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313020112.GB1148@sol.localdomain>
References: <20240313020112.GB1148@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The only user of comp_alg_common was the crypto stats, and it was introduced by
> a refactoring of the crypto stats (commit 0a742389bcc0, "crypto: acomp - Count
> error stats differently"), so it seems appropriate to remove it for now.
> 
> If you could go through my patch and explain what other unused code related to
> the crypto stats you might consider to be "infrastructure" that should not be
> removed, that would be helpful.

Hi Eric,
that user is mm/zswap [1], apologize it was not in crypto tree. I guess you might
just need a new version to keep that one :-)

[1] https://lore.kernel.org/linux-mm/20240222081135.173040-2-21cnbao@gmail.com/ 

> - Eric

Thanks
Barry


