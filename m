Return-Path: <linux-kernel+bounces-25694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D39CD82D4AC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061BC1C21068
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E69441B;
	Mon, 15 Jan 2024 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="XXZBeuPO"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6DC29B4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1705304483; x=1705909283; i=efault@gmx.de;
	bh=trwWax8DDmfk9uCdNMuSFE5cjaMNOY698wfxBoc8254=;
	h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:
	 References;
	b=XXZBeuPOKruDJ9Ec/5qB7Uks03CGkoca1zXgu2OSmrrqcL/Ld7ouNDx3HNHpLjFi
	 yvR38xR8ZMRzMfVjkucz4gGGE55u6yX7QqtqD8j4OUHwehs+0FEOK1EE7Jbnpm3bh
	 9SSD6vWWjXQGjOzNO4jXMafvOATCWaK8zdvyG8Sj889yCZHZvACwID6oJxx5S8sVB
	 Bc7MQWXkIJtRu5TpaFsK0EBO/kPXY/SWV6E0L837HT/gJC6ymUC4zz3RkU6Me6q4w
	 vpH7fYDRnfsfzj8o+WeUfrAretpaLbgalj8RpvLuPfzeVq5X6rB+w4EJKY6tEXlS+
	 OPEHSLfvC3CMHO0H9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.148.45]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MStCY-1rZe0L3C5W-00UJp8; Mon, 15
 Jan 2024 08:41:23 +0100
Message-ID: <61ba46217934e70f14e84b7b3e467c033854b6c3.camel@gmx.de>
Subject: Re: [PATCH] sched/eevdf: using leftmost improves the readability of
 the code
From: Mike Galbraith <efault@gmx.de>
To: Liu Song <liusong@linux.alibaba.com>, mingo@redhat.com, 
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org
Date: Mon, 15 Jan 2024 08:41:22 +0100
In-Reply-To: <20240115044619.34718-1-liusong@linux.alibaba.com>
References: <20240115044619.34718-1-liusong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G0zyRDUO694oJzrNtdMbsuSSPsAATD2dfiMoQ6N6YyskDyLsEr+
 NjWLGDAEQFxAuCqHb3NVVIJE6P7EOZpMSBgabUmJfl2YSwl1D/I1D8qc2OFBOqmVUHUq5HO
 uBOEvTDGJJlrS5t/ZeC5edWqidN05VJzsTCtSOyeaIPCIiPxaTyGyOj0AHnrO55LNsyhG/R
 qGBg9Q8FhOxX9O8CNRrgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pEfcuVR8V7g=;rYwwshs5epwR3Ce2ql4pmJ5TE++
 2xxAtnwhBN+JtXrGc2pNvXgF9u7aE5p0q4zOh16y/aJK1Wc1nELMIFLV8nZ9waxD7a+2Xq3mU
 BeR8ntKQ7FPaiCl2X61SuNTFH7T7yjrEKBocaNChZ5cGy5ujkwo6Ublm92KyDWtuf7LyoH3Y2
 zaD9yEzFt+JmXvrqe2/QHL4w5wAtggAJ77Y821D84elU9QkLDJ4iJpTq2RKLAo/XbwS3Nutcl
 U+ZzQa6C9od6YDANyqqi+nvJWGhXWWolp18UofETsIZ7f4z6o0LZx5/P6AVvAgrBzaDPK6QSE
 CFiAf2DEzfvjhJyiIM1LaRpMm2lN4pkixRm7vA2mXbyGT6CQGajmpPjrsmiS/jILyQlLKWr3y
 ZuBPwP3El2s2RBsyx5/9ZJ4AitzdP9qmIxELRE63NruNrIcdwgY5go7gKN5r27GOBTztqz2yG
 RGbl1KLfbtg1ZqhYk/CP3CuciwzuRaX7HhKcNL2Km2OtkcrylhOl3Zwr774gJ1ZyXKgrnvURN
 39R+iuj0HNSARGg9ZzhkiPn9zEf6TmWBT8SR21trT7ICB/xcQBDb5DC+L118PQq8v62PtstcQ
 FOsOqWqPn5qNSaWckdWrMaa/4pvN9HAUdD+wsgeWt7BHEUxAPNvbwCaE9MsPJp7MyV0GKjSik
 IUOuaZrxJk8S0m4slvEAX9SOHIWOulLexdfmOYnCDriHY8HC0l4V4NierStL5BBnIIBgc/ivE
 K9ITxgmznxkQgcJOh5U+kxYasKXpvaZpvdiHgCUI6uiVQr8AHFo7zuuwSFq8rPa0S2qhvchXJ
 qYenittNcw3mBST8MZD8nNNFWNU2QvSjRr7F2qBh5XiC3DRANI5o9opWtR1IXrLTitIEdFgzY
 slj/ryqP5t5CEEofzJNo541g2uJm0ai7PkuTidNwMfEmRdZv8CEiRQ53AYff5Zf/5QNSXbGK2
 vFSR4Aq+njxb63LzHwpxw6V3Yb8=

On Mon, 2024-01-15 at 12:46 +0800, Liu Song wrote:
> Using 'leftmost' enhances code readability..

Not even a little bit, it's already blatantly obvious at a glance.

> Signed-off-by: Liu Song <liusong@linux.alibaba.com>
> ---
> =C2=A0kernel/sched/fair.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f2bb83675e4a..4247584258ae 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -848,12 +848,12 @@ struct sched_entity *__pick_root_entity(struct cfs=
_rq *cfs_rq)
> =C2=A0
> =C2=A0struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct rb_node *left =3D rb_f=
irst_cached(&cfs_rq->tasks_timeline);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct rb_node *leftmost =3D =
rb_first_cached(&cfs_rq->tasks_timeline);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!left)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!leftmost)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return __node_2_se(left);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return __node_2_se(leftmost);
> =C2=A0}
> =C2=A0
> =C2=A0/*


