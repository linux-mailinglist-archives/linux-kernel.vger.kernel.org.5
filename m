Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1113277F68B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350829AbjHQMkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350942AbjHQMkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:40:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2682D78;
        Thu, 17 Aug 2023 05:40:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD32B65333;
        Thu, 17 Aug 2023 12:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D78C433C8;
        Thu, 17 Aug 2023 12:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692276006;
        bh=Ctb460ZjOOcTO7ad0Uh+wY0jeurBU6YyzveRXdTvoeo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PAgn19Tqk7HPGUNIiGTm5Rb3MkGu3mNCy4LzMMSBKojyioGJrDm4n8lUxvupfYHRr
         qJkBx/kni6erq2oX1y5d2Z9qYCk2VdupWR24y8sH41TuLA2slzLFzFwYSyLe0BNHEK
         6KAy0uhsfcXXZY5cOWE0p9fc0D6cBQoWn4X++j/ca7Xr5z7vjWjhg4dk22k2otnbOk
         x+e+IZNVawl2cS51nMnGQos7Zy1xd9vgyaMqUQ1Ls6V9LTZIfRoEbCUsc30lQtz5EM
         0KCPpin7XBF3VkziU8kM/mfA69Uy7S5Zjd60mce99YYTtbXmEm7Pqc0/BniXmcyK8P
         14I7gOMYBLjjA==
Message-ID: <09b4a2ce-da74-3a19-6961-67883f634d98@kernel.org>
Date:   Thu, 17 Aug 2023 14:39:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: struct_size() using sizeof() vs offsetof()
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
References: <74e8cf91-d095-33e3-c548-34d80b691089@kernel.org>
 <202308161913.91369D4A@keescook>
From:   Alejandro Colomar <alx@kernel.org>
Organization: Linux
In-Reply-To: <202308161913.91369D4A@keescook>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------dOwP5D6f8lsAhQZrmPhEqIdx"
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------dOwP5D6f8lsAhQZrmPhEqIdx
Content-Type: multipart/mixed; boundary="------------736sc8nit74FyAlUvH570gdz";
 protected-headers="v1"
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Message-ID: <09b4a2ce-da74-3a19-6961-67883f634d98@kernel.org>
Subject: Re: struct_size() using sizeof() vs offsetof()
References: <74e8cf91-d095-33e3-c548-34d80b691089@kernel.org>
 <202308161913.91369D4A@keescook>
In-Reply-To: <202308161913.91369D4A@keescook>

--------------736sc8nit74FyAlUvH570gdz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi!

On 2023-08-17 05:05, Kees Cook wrote:
> On Thu, Aug 17, 2023 at 02:23:21AM +0200, Alejandro Colomar wrote:
[...]

>=20
> When struct_size() was originally implemented this topic came up, and w=
e
> opted for potential over-estimation rather than using offsetof() which
> could result in under-allocation, and using max() of two different
> calculations just seemed like overkill. Additionally, almost all cases =
of
> struct_size() was replacing a literal open-coded version of
>=20
> 	sizeof(*ptr) + sizeof(*ptr->array) * count
>=20
> So avoiding a difference in calculation was nice too.

Yup.

[...]

>>
>> 	MAX(sizeof(s), offsetof(s, fam) + sizeof_member(s, fam) * count)
>=20
> Ironically, this has been under careful examination recently by GCC[1]
> too. Though that has mainly been looking at it from the perspective
> of how __builtin_object_size() should behave in the face of the new
> __counted_by attribute.

Heh, I've found that there are actually a lot of discussions about flex
arrays going on this summer.  Glibc also has something.

[...]

>=20
> We opted for simple over complex, with the understanding that
> over-allocation will be a relatively rare issue that will only waste
> limited space (as opposed to potential under-allocation and risking
> writing beyond the end of the region).

Thanks.

[...]

> But, yes, at the end of the day, struct_size() could be defined as
> max(sizeof, offsetof-based struct-size).
>=20
> Note that struct_size() has been designed to have two additional
> behaviors:
>  - be usable as a constant expression
>  - saturate at SIZE_MAX
>=20
> So as long as the max() could do the same (which it should be able to),=

> it'd likely be fine.

Yep.  It should be able to do that.

> I'm open to patches as long as we can validate any
> binary differences found in allmodconfig builds. :)

Thanks!  I'm preparing a patch.  It's being more complex than I thought
it would be.  There's some thing that's not compiling for me.


net/sched/cls_u32.c: In function =E2=80=98u32_init=E2=80=99:
net/sched/cls_u32.c:369:17: error: cannot apply =E2=80=98offsetof=E2=80=99=
 to a non constant address
  369 |                 tp_c =3D kzalloc(struct_size(tp_c, hlist->ht, 1),=
 GFP_KERNEL);
      |                 ^~~~
In file included from ./include/linux/kernel.h:27,
                 from ./arch/x86/include/asm/percpu.h:27,
                 from ./arch/x86/include/asm/nospec-branch.h:14,
                 from ./arch/x86/include/asm/paravirt_types.h:27,
                 from ./arch/x86/include/asm/ptrace.h:97,
                 from ./arch/x86/include/asm/math_emu.h:5,
                 from ./arch/x86/include/asm/processor.h:13,
                 from ./arch/x86/include/asm/timex.h:5,
                 from ./include/linux/timex.h:67,
                 from ./include/linux/time32.h:13,
                 from ./include/linux/time.h:60,
                 from ./include/linux/stat.h:19,
                 from ./include/linux/module.h:13,
                 from net/sched/cls_u32.c:26:


Here's the entire function:

$ grepc u32_init
=2E/net/sched/cls_u32.c:352:
static int u32_init(struct tcf_proto *tp)
{
	struct tc_u_hnode *root_ht;
	void *key =3D tc_u_common_ptr(tp);
	struct tc_u_common *tp_c =3D tc_u_common_find(key);

	root_ht =3D kzalloc(struct_size(root_ht, ht, 1), GFP_KERNEL);
	if (root_ht =3D=3D NULL)
		return -ENOBUFS;

	root_ht->refcnt++;
	root_ht->handle =3D tp_c ? gen_new_htid(tp_c, root_ht) : 0x80000000;
	root_ht->prio =3D tp->prio;
	root_ht->is_root =3D true;
	idr_init(&root_ht->handle_idr);

	if (tp_c =3D=3D NULL) {
		tp_c =3D kzalloc(struct_size(tp_c, hlist->ht, 1), GFP_KERNEL);
		if (tp_c =3D=3D NULL) {
			kfree(root_ht);
			return -ENOBUFS;
		}
		tp_c->ptr =3D key;
		INIT_HLIST_NODE(&tp_c->hnode);
		idr_init(&tp_c->handle_idr);

		hlist_add_head(&tp_c->hnode, tc_u_hash(key));
	}

	tp_c->refcnt++;
	RCU_INIT_POINTER(root_ht->next, tp_c->hlist);
	rcu_assign_pointer(tp_c->hlist, root_ht);

	root_ht->refcnt++;
	rcu_assign_pointer(tp->root, root_ht);
	tp->data =3D tp_c;
	return 0;
}


Let's see the structure type:


$ grepc -tt tc_u_common
=2E/net/sched/cls_u32.c:86:
struct tc_u_common {
	struct tc_u_hnode __rcu	*hlist;
	void			*ptr;
	int			refcnt;
	struct idr		handle_idr;
	struct hlist_node	hnode;
	long			knodes;
};


Huh, hlist is the first field and is a pointer.  I'm not at all
sure of what was being done here.  Here's the type of the
pointee:


$ grepc -tt tc_u_hnode
=2E/net/sched/cls_u32.c:70:
struct tc_u_hnode {
	struct tc_u_hnode __rcu	*next;
	u32			handle;
	u32			prio;
	int			refcnt;
	unsigned int		divisor;
	struct idr		handle_idr;
	bool			is_root;
	struct rcu_head		rcu;
	u32			flags;
	/* The 'ht' field MUST be the last field in structure to allow for
	 * more entries allocated at end of structure.
	 */
	struct tc_u_knode __rcu	*ht[];
};


So, that struct_size() was, at best, doing black magic.  At worst, a
bug.  I would need to investigate that code a little bit more, but a
first guess tells me that struct_size() was returning the size of the
outer structure plus the size of the flex array in the inner structure,
but not including the size of the inner structure; i.e.:

	sizeof(outer) + flex_array_size(inner-flex)

which seems a weird calcualtion.

That line of code was written by Gustavo, in d61491a51f7e ("net/sched:
cls_u32: Replace one-element array with flexible-array member"), so
can you please confirm that code, and maybe explain why it's that way,
Gustavo?

-               tp_c =3D kzalloc(sizeof(*tp_c), GFP_KERNEL);
+               tp_c =3D kzalloc(struct_size(tp_c, hlist->ht, 1), GFP_KER=
NEL);


Cheers,
Alex


>=20
> -Kees
>=20
> [1] https://gcc.gnu.org/pipermail/gcc-patches/2023-August/626672.html
>=20

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5


--------------736sc8nit74FyAlUvH570gdz--

--------------dOwP5D6f8lsAhQZrmPhEqIdx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmTeFRwACgkQnowa+77/
2zJuRg/8CECOrscSkBJfDRl6z28OCGGZlW8xiw1XMW8erqD8rbLKY8Yqqs7DOzdK
TXGokPlffwLjdAca2yiLx4aZyuXE+31OdLY75o9gPRwwogjzAjCHUj0lFq4AbR/3
H5a/s8ydrjY8UR7FkLfjw5z2NjwMnKyhGiDS6mcS9zMSMqlYr3LTemE4xOIVGpXo
tr/Ja99v5oeaws/8FWy3PZBpmR8ERMvX8c2UjS90lGp/pvIRoRKPuXGX0zaFNCzh
RmW05InWPll/99gDsUnQhbGXsyBSCsevkWcPSJLMqF3PdK6LhUheDlDqeWq2kQPu
HGtEBvx6uzkyrMd7s1m86G947zv4GID+Lm1sLFcCw0NkvBWJvntFlomls4QBGX0p
DA8+Ta5KLSlas0WJaipb+QJQhbhWzgcJZ5YwVGOJBQ+II63+RtbGcu75sRai5EjN
9NVXpMvTozhwq/Cq//Ui2nUP+YV/0HehFkcyUQsVunsig+tnK1enj1YxTa0gSvoN
YDrv5WXWqUBoAivlkEJIjODC/GK48i0WbWexDV91VtgodUah6S6ROaPcqwlkNMa+
y0MIT2qehcEaoxZAOI+qd5u8NofcWE0r5x3PYfDP1JKND3Yn1f8P1bzJiXM+mxKa
Vj5raN/NQefUa20v8pb43vs7j8G7h6UrkwYbkSaVzWvaZkzkeaQ=
=U7HT
-----END PGP SIGNATURE-----

--------------dOwP5D6f8lsAhQZrmPhEqIdx--
