Return-Path: <linux-kernel+bounces-151911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0428AB5A8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712101F2270E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA7213C9B1;
	Fri, 19 Apr 2024 19:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YooUtFDp"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8611425740;
	Fri, 19 Apr 2024 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713555736; cv=none; b=TnCgna6bvkHDB3owRexXiRte+y8WshN1OAjzPpChpTnMLUvjyBqRPg2qJwR7/oNiqnZewmJAoqXCtv4NAfoqGO/9WPKSf2jc2i44UNGl3rCWIfulzYeIEL/hKYk7+GXUPUpjghuZl8/F2Hsbz/UIjXxEYnMK6/6GTMgY0vnB5QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713555736; c=relaxed/simple;
	bh=uyMz+5agVBSVEi4Ga+1h11jGQlr5IOfzTQGb7A2+i6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMSW9k3TK8Gct5hS0vK7iu1DO/IYnHONEtleJ27K5/hMnZ3Bb4jvB13QWgk4ZmuLWzXEEWaXRvLC1fFI/GtWy1OUXJ3gSdRkNamMNE7ZkbBJjHKZ/kbSwJl0rIHbbYpy5qFAvb+PAhl6U7Hd8GKbVhb/8i0SXjx9OsDuWNYOhjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YooUtFDp; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2db6f5977e1so32478141fa.2;
        Fri, 19 Apr 2024 12:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713555732; x=1714160532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyMz+5agVBSVEi4Ga+1h11jGQlr5IOfzTQGb7A2+i6c=;
        b=YooUtFDpnmMqJfbzYtfkP+FB0ik/r0q2tAHtx39qLyDau4IqMcAVcQxvkNKTrL7Ae+
         O+nCgBlL6Lh/qfayPTkbCipb1SnrI0T7f1eahcn8CxxZJVYr7mPqhwgy02wql6L91Fsv
         YAzYd0ASIV6tzCD+v8dwi/OoowjMHicIJMwOCRuiywy3ZhbL5yIFfPit2DVM0d81wDAm
         VQjgSPbcqa3ZMaaHnQ9vn9HPaAY+5vi5iDfoChJ0erKKhLIk3xHIeVd9AxJ5GXtpun2K
         TZuOaXV3iIrjS3xrvM8LwzEuzluRJzAHhFBXi1rN1uy+KYOypAi+dGCL2McNNG4YvrZ6
         HyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713555732; x=1714160532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyMz+5agVBSVEi4Ga+1h11jGQlr5IOfzTQGb7A2+i6c=;
        b=MxAIhMtGlC97uGD+XFvVJUKitsSX1AmRBbvkyPxNYA0vFuzMDfJcwlItehJKV+/cO4
         uApN3emU0kvs8OGe2kI3biUMPUwtoCmx2rFOyiNe6fwwO8XMDr1w0+GS33freqa4Uy4N
         m6EI/A77yA6/4jjDfFgAC63ZGQ/s4ql2WysOd/h45lswOnY4gt15MGpkyzRoNtt4iV16
         xWefm09i/Qo08rgJCXTa94K4hU4kA6vJfl0R/b2mrEYFo5osqnfh2Qsya2US9lW7ckM9
         AISo+VLqJ6db/MPuV26w+DXMz6vuYPn/7zI3SkB8GFW9foPUrBWchw4i+NHwTZ+f9AWH
         LIVA==
X-Forwarded-Encrypted: i=1; AJvYcCWdzjc3I5/uDtb2yqp5AYs24P8Kb++UFv2riiWsNf/LwTXJW2WmQNwnGazCVliAaOQIG077TMyVIOdNd0qsyEkxu5K90G1cIM5FNv0t+OiMRuPj+qrtQfhT2lqhPBi3dy8uRBS1W0m3Cy0a8l8+APUN/25Ga1wnEGjt8Se5ju+Vkm1pCUcKpI4PvWQBwdNH
X-Gm-Message-State: AOJu0Yyownk1XenY8+r6oBjpG1xqiXjIQ9dO4vQw/+acYUySJnPKpJ6w
	PB2us4IJdMCkLQvBK9bPSbtBMvXjACjyllrisufMYoL38EfcC174SvY8ymPMzGWU93rVLVuo/HA
	XEIcVOAfjS+anbGe5M0DKbWe8mJc=
X-Google-Smtp-Source: AGHT+IHLNy/Po1edLygtZJom4CsUlR5CbZo3KM1lH6iARm4i+Imm8HaxPbs6daWiXd49JGyav9kIvcytqWm3A2N6lPs=
X-Received: by 2002:a2e:bc19:0:b0:2da:6b4:8b16 with SMTP id
 b25-20020a2ebc19000000b002da06b48b16mr2152099ljf.29.1713555732487; Fri, 19
 Apr 2024 12:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <da0859c4b24d314d9ff38179c26a58ee7e3f16d6.1713395895.git.sean.wang@kernel.org>
 <cb593f2a-7dbe-44aa-b9ff-7fc57a4bd70a@web.de>
In-Reply-To: <cb593f2a-7dbe-44aa-b9ff-7fc57a4bd70a@web.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 19 Apr 2024 15:42:00 -0400
Message-ID: <CABBYNZL1=RyzuXcDpAwcXyOe_8Bh4gJtDzKdS55-3ZF4rZRj7A@mail.gmail.com>
Subject: Re: [PATCH RESEND] Bluetooth: btusb: medaitek: fix double free of skb
 in coredump
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Sean Wang <sean.wang@mediatek.com>, linux-bluetooth@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	LKML <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@kernel.org>, 
	Chris Lu <chris.lu@mediatek.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Deren Wu <deren.wu@mediatek.com>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Manish Mandlik <mmandlik@google.com>, 
	Miao-chen Chou <mcchou@chromium.org>, Michael Sun <michaelfsun@google.com>, shawnku@google.com, 
	frankgor@google.com, jsiuda@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,

On Thu, Apr 18, 2024 at 5:40=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> > hci_devcd_append() would free the skb on error so the caller don't
> > have to free it again otherwise it would cause the double free of skb.
>
> I hope that a typo will be avoided in the subsystem specification
> for the final commit.

Are you talking about medaitek or is there another typo?


> Regards,
> Markus



--=20
Luiz Augusto von Dentz

