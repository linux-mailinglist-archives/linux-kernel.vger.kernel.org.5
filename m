Return-Path: <linux-kernel+bounces-19576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A6F826F0D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E1D282E29
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACE441209;
	Mon,  8 Jan 2024 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZDzd95m"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECA040C0C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704718491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9/XzYGtf3zuy1/gN/Tcx1jMZeUXDmt2Uyj9YvqrOzQ=;
	b=DZDzd95m0m6+UJoBN17V9Ht0K7lSol1T7ANR9tQqSVXl7R6SWgHgWrXsUY6/GV7s+MxA+2
	K15EtJ2lJ3enN0jRr+5se+2DheVzLwksTfAEIvX8s5n034lqnfkdJl/XoTz5g4xJLBcdwx
	vJqRyrjByerD/ZHRbldrOlyWQEQZPI8=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-qbztXik_PrSXz1kwH-qFmg-1; Mon, 08 Jan 2024 07:54:50 -0500
X-MC-Unique: qbztXik_PrSXz1kwH-qFmg-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-466f4639ef7so2765372137.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 04:54:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704718490; x=1705323290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9/XzYGtf3zuy1/gN/Tcx1jMZeUXDmt2Uyj9YvqrOzQ=;
        b=LjubXAvBtgew/VQAYvZJFTXxAtPAafrbaHCmHTAo4bTPsxkqeExJtbKuN9lQ5KAFe9
         HvdUeEit2BaSPW/Nb+c8qBtl88eHQZ1Hh/U+9IW5pBY7keD8MhdZms1dXqGX82eEowjB
         xEeNaH1pCwMrpYOysLff96rVBVvCyKMe9YTKg0QwNXm45k2P40W9jMrTXLvL4dE5fM4i
         WJ13Txxnn5fLy/RX0w7rgYp3e64gwdXY4oCRZsidZ1Z3khCi8ScfNVMrWCAxFBiX4OXb
         oTzHgxLIY4VXsM+IeeY/hWNijmqYgyq/6GJlFHYLsfSd1BbuuWDGdZPdWM/PnJXR1ES1
         tGCg==
X-Gm-Message-State: AOJu0YxNfX/g4PHkQo+WtGnUfEhyQWVKW6aSxH+TjCxbmSAdWrJlyFWq
	DSSWzXjlD+YOmduznilHlOgTzLngz7dJ59hQFm7QweatWIK5/U0i9mj8bRLp67NQ+ig6RUAiLTD
	mNPp6Xp/9lhHya/KU/QGRgSBN7h8YClxXimYy+5QnLyfCPBL3
X-Received: by 2002:a05:6102:41ab:b0:467:c27a:ee36 with SMTP id cd43-20020a05610241ab00b00467c27aee36mr1983332vsb.3.1704718489899;
        Mon, 08 Jan 2024 04:54:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEHYwL+cKo3CUEW0LoVY+W3kcW8vUISpsYg6AY5XbAYP9iRvhAGefNSkZ9qg1ovwO9G25gElUUSms2b2gHmVQ=
X-Received: by 2002:a05:6102:41ab:b0:467:c27a:ee36 with SMTP id
 cd43-20020a05610241ab00b00467c27aee36mr1983327vsb.3.1704718489605; Mon, 08
 Jan 2024 04:54:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104193303.3175844-1-seanjc@google.com> <20240104193303.3175844-2-seanjc@google.com>
In-Reply-To: <20240104193303.3175844-2-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 8 Jan 2024 13:54:37 +0100
Message-ID: <CABgObfamcmdyevL1HCfri65wGnHwDeRB+NyCn0M0pONQLHxZPA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: non-x86 changes for 6.8
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 8:33=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Please pull a few minor changes that aren't (just) x86.  The
> vmemdup_array_user() patches were sent as a series, and the s390 folks we=
re
> quick on the draw with acks, so it was easiest for all involved to just g=
rab
> everything in one shot.
>
> The following changes since commit e9e60c82fe391d04db55a91c733df4a017c28b=
2f:
>
>   selftests/kvm: fix compilation on non-x86_64 platforms (2023-11-21 11:5=
8:25 -0500)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-generic-6.8
>
> for you to fetch changes up to 1f829359c8c37f77a340575957686ca8c4bca317:
>
>   KVM: Harden copying of userspace-array against overflow (2023-12-01 08:=
00:53 -0800)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> Common KVM changes for 6.8:
>
>  - Use memdup_array_user() to harden against overflow.
>
>  - Unconditionally advertise KVM_CAP_DEVICE_CTRL for all architectures.
>
> ----------------------------------------------------------------


