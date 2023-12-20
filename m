Return-Path: <linux-kernel+bounces-7647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D958081AB33
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17BB61C20C5D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A1D4AF75;
	Wed, 20 Dec 2023 23:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAgtexFs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4555E45C09
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 23:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-203ae9903a6so102981fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703115890; x=1703720690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRiqn6qJxrITE4e2Ib4uvsrQtS1W15KSJpparCjQXiQ=;
        b=VAgtexFsIjLFn3kKdorFLTJ3qjUaG7fEI2MEPHX+g+n++pITAn6AVsikod4otn3VNH
         WYfM9zgKJWi8R7FufWBhldLTnOTZdnkjEtM+a3Kt5+jdzsKG7HoU5ujZ/Fha+K+azWCm
         stcRdseDr2v4dvjoPXC0aNNNvA92wmcXHd9i83ko5H6Ctc+Hif/JR+Lu1WjZoLHd3Ixl
         BrKTzDttM7lDafZrFC5kN5XmI4QVV1Jb9BHMg0P1Tj6rTpxoBmGphX80dO36sowig3rW
         NoLEpSyrva3IRhQxLy7JQq4WiLTTaq5x1gFujTXfv/crocOEo1oDeUPHqvAyazqQE4H1
         ePgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703115890; x=1703720690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRiqn6qJxrITE4e2Ib4uvsrQtS1W15KSJpparCjQXiQ=;
        b=Ucj65A2pCUsp5n9Gf773QlwHrs4sZe5Rs1OQUobpqRhBWU1UPFOcyMa9dmVWGSIOO1
         vLA8oq5u9T92rl2iOmjBQqOJ8sAtp2DvgnZreC2AuFzThxnsqYh5fFMil2OuX64zXTPU
         4dtb2D9hy19Ukr8bE/OVGGvJZHLGtGETZZBm2kTDK4/09ILZc9FbI4H9QF0HASJHxfdQ
         ohRjUNB9uUtv+PwZg4iJFkyLwbm3ToflAUcv419VtvsFlRVCvUNW7JmlAI13Bku3mi9S
         B8UEyDWjwb2kqmJrXDlzDV9KhV8qGxeYvvspJJWDoxnfpdljV2CiV0h/NT/RqvkXTCWY
         A0+Q==
X-Gm-Message-State: AOJu0YyrVvVD7Qh+R+MQHH749LrTocZq2FN3ySgIsddwsO1zyQsqCpG5
	pdvzkOuphnmh6km1beALaxtwt459enDkVlOmNAI=
X-Google-Smtp-Source: AGHT+IH+pRXG0dXATCm/Jj7PbmLI8Ix04/Czb6RDIE+lIk2Mka2s1cM1O73JE0iRfIWqKM6/C7Pcn68n28uwlfZIAfo=
X-Received: by 2002:a05:6871:288:b0:204:1ae1:e538 with SMTP id
 i8-20020a056871028800b002041ae1e538mr546549oae.6.1703115890207; Wed, 20 Dec
 2023 15:44:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204-slub-cleanup-hooks-v1-0-88b65f7cd9d5@suse.cz>
 <20231204-slub-cleanup-hooks-v1-4-88b65f7cd9d5@suse.cz> <44421a37-4343-46d0-9e5c-17c2cd038cf2@linux.dev>
 <79e29576-12a2-a423-92f3-d8a7bcd2f0ce@suse.cz> <fdd11528-b0f8-48af-8141-15c4b1b01c65@linux.dev>
 <CANpmjNO1_LxE9w4m_Wa5xxc1R87LhnJSZ3DV59ia3-SdQUmtpw@mail.gmail.com>
 <CA+fCnZfhqQ+n0SsZU0RKEov3CkwTNJXM7JTMxtkrODmbJPskDQ@mail.gmail.com> <fec2561d-42fb-dd47-6e8f-3b55aaf39d85@suse.cz>
In-Reply-To: <fec2561d-42fb-dd47-6e8f-3b55aaf39d85@suse.cz>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 21 Dec 2023 00:44:39 +0100
Message-ID: <CA+fCnZecUGRdqwfebu9C+hBN3_mW_VNhjm4FUXOo9Xak58NKdQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm/slub: free KFENCE objects in slab_free_hook()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Marco Elver <elver@google.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 12:42=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 12/11/23 23:11, Andrey Konovalov wrote:
> > On Wed, Dec 6, 2023 at 3:45=E2=80=AFPM Marco Elver <elver@google.com> w=
rote:
> >>
> >> The is_kfence_address() implementation tolerates tagged addresses,
> >> i.e. if it receives a tagged non-kfence address, it will never return
> >> true.
>
> So just to be sure, it can't happen that a genuine kfence address would t=
hen
> become KASAN tagged and handed out, and thus when tested by
> is_kfence_address() it would be a false negative?

No, this should not happen. KFENCE objects never get tags assigned to them.

