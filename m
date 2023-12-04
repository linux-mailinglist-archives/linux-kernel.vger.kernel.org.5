Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F3F803F51
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjLDUbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbjLDUbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:31:17 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BC6B2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:31:22 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-4b2eee90c9fso193899e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 12:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701721882; x=1702326682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHOTw/hHu1W6a8gE8MvL1I55BVoLnlgfGATt69ywW/M=;
        b=McfvK+0HoELf8B7xdPM96Hp78GSY32xMRCNf1lV1mWGtwh36VLI0F6c4B47REbkTiS
         k67Gwja/cf65o9V4JegULyPtbIRIY2v96CZ6XDjsizaPLAcBLDegupFzjrV6kIKMjOYo
         7R2oL/QxwfzujZEM6QRKTuwv+kK/H2rQgsw5JOfsehIxAU9unIlwi2VBMEnImFkGs9I1
         I8kJWJKaKwRPj/z1o8PEI2Gjk7JdS5HRIzTbi5tALO1y+Zf1kVSDAMEs7lq12kRLN2GC
         lOEkQk7nNoRgjWlHIZ+ELVkVbeF00tgd1QrOHHllIIRd/3kqYNayCjHRNqQz49Vd8xtG
         qlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701721882; x=1702326682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHOTw/hHu1W6a8gE8MvL1I55BVoLnlgfGATt69ywW/M=;
        b=MHWv0mok4xDO1nnx+G/56EQYiNSDRgLGXNe/Mo7tPZc67oopgwEjPbkSdj7uR+LUXh
         0O+obvq2bUSbIdDCbvGyNbrDekkdMig/fPFE4PgSJehc1rVAdAmdi3hLn5Xs6upGsoIw
         JP1uWYcmxUsCaqDArgy3OcD1rhu8Rj7rWff2Bca5oa+UmIntSVD/M0S0S21zAnRL6sJ/
         hUPnuvvL7PumXlBJm8g+s25Aje+EqIsIXhj5TieX/rn+v89dLj9kx+Vrk7TMizqC4uha
         PJLkH7AHV/AHWQuY/St438UYpwDuLBlmy5drMHv63mkx5J1qZUU5w3OAh98ik9QCxHV8
         nd/w==
X-Gm-Message-State: AOJu0YxcRLoqUzXHH+fO4Iz+EWezh4X1eo5gPgcYHYgfL3H0HukRdsoT
        bQdq5b21wx3WL3O1fn8GIqCYIb3lkiNhJoib5S4=
X-Google-Smtp-Source: AGHT+IG8Ay/sQ1tMjkxyk8HJSBTIwBRWMSIqdL0X7l+OmX32lI8pMC+w5bKItQUX/iXyujumizlRs34pprlsdMMI2DI=
X-Received: by 2002:ac5:c965:0:b0:49a:9a34:ec40 with SMTP id
 t5-20020ac5c965000000b0049a9a34ec40mr1578943vkm.2.1701721881938; Mon, 04 Dec
 2023 12:31:21 -0800 (PST)
MIME-Version: 1.0
References: <20231127-module_linking_freeing-v4-0-a2ca1d7027d0@rivosinc.com> <20231127-module_linking_freeing-v4-1-a2ca1d7027d0@rivosinc.com>
In-Reply-To: <20231127-module_linking_freeing-v4-1-a2ca1d7027d0@rivosinc.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 4 Dec 2023 20:30:55 +0000
Message-ID: <CA+V-a8tLhbLs7V_vbrzfFcFbqfCiWZAEDrxftzn_Udsa=hb6ng@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] riscv: Safely remove entries from relocation list
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Ron Economos <re@w6rz.net>,
        Samuel Holland <samuel.holland@sifive.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 10:08=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.=
com> wrote:
>
> Use the safe versions of list and hlist iteration to safely remove
> entries from the module relocation lists. To allow mutliple threads to
> load modules concurrently, move relocation list pointers onto the stack
> rather than using global variables.
>
> Fixes: 8fd6c5142395 ("riscv: Add remaining module relocations")
> Reported-by: Ron Economos <re@w6rz.net>
> Closes: https://lore.kernel.org/linux-riscv/444de86a-7e7c-4de7-5d1d-c1c40=
eefa4ba@w6rz.net
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/kernel/module.c | 110 +++++++++++++++++++++++++++++++++------=
------
>  1 file changed, 82 insertions(+), 28 deletions(-)
>
This fixes issues seen on RZ/Five SMARC EVK.

Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> #On
RZ/Five SMARC EVK

Cheers,
Prabhakar

> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index 56a8c78e9e21..53593fe58cd8 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -40,15 +40,6 @@ struct relocation_handlers {
>                                   long buffer);
>  };
>
> -unsigned int initialize_relocation_hashtable(unsigned int num_relocation=
s);
> -void process_accumulated_relocations(struct module *me);
> -int add_relocation_to_accumulate(struct module *me, int type, void *loca=
tion,
> -                                unsigned int hashtable_bits, Elf_Addr v)=
;
> -
> -struct hlist_head *relocation_hashtable;
> -
> -struct list_head used_buckets_list;
> -
>  /*
>   * The auipc+jalr instruction pair can reach any PC-relative offset
>   * in the range [-2^31 - 2^11, 2^31 - 2^11)
> @@ -604,7 +595,10 @@ static const struct relocation_handlers reloc_handle=
rs[] =3D {
>         /* 192-255 nonstandard ABI extensions  */
>  };
>
> -void process_accumulated_relocations(struct module *me)
> +static void
> +process_accumulated_relocations(struct module *me,
> +                               struct hlist_head **relocation_hashtable,
> +                               struct list_head *used_buckets_list)
>  {
>         /*
>          * Only ADD/SUB/SET/ULEB128 should end up here.
> @@ -624,18 +618,25 @@ void process_accumulated_relocations(struct module =
*me)
>          *      - Each relocation entry for a location address
>          */
>         struct used_bucket *bucket_iter;
> +       struct used_bucket *bucket_iter_tmp;
>         struct relocation_head *rel_head_iter;
> +       struct hlist_node *rel_head_iter_tmp;
>         struct relocation_entry *rel_entry_iter;
> +       struct relocation_entry *rel_entry_iter_tmp;
>         int curr_type;
>         void *location;
>         long buffer;
>
> -       list_for_each_entry(bucket_iter, &used_buckets_list, head) {
> -               hlist_for_each_entry(rel_head_iter, bucket_iter->bucket, =
node) {
> +       list_for_each_entry_safe(bucket_iter, bucket_iter_tmp,
> +                                used_buckets_list, head) {
> +               hlist_for_each_entry_safe(rel_head_iter, rel_head_iter_tm=
p,
> +                                         bucket_iter->bucket, node) {
>                         buffer =3D 0;
>                         location =3D rel_head_iter->location;
> -                       list_for_each_entry(rel_entry_iter,
> -                                           rel_head_iter->rel_entry, hea=
d) {
> +                       list_for_each_entry_safe(rel_entry_iter,
> +                                                rel_entry_iter_tmp,
> +                                                rel_head_iter->rel_entry=
,
> +                                                head) {
>                                 curr_type =3D rel_entry_iter->type;
>                                 reloc_handlers[curr_type].reloc_handler(
>                                         me, &buffer, rel_entry_iter->valu=
e);
> @@ -648,11 +649,14 @@ void process_accumulated_relocations(struct module =
*me)
>                 kfree(bucket_iter);
>         }
>
> -       kfree(relocation_hashtable);
> +       kfree(*relocation_hashtable);
>  }
>
> -int add_relocation_to_accumulate(struct module *me, int type, void *loca=
tion,
> -                                unsigned int hashtable_bits, Elf_Addr v)
> +static int add_relocation_to_accumulate(struct module *me, int type,
> +                                       void *location,
> +                                       unsigned int hashtable_bits, Elf_=
Addr v,
> +                                       struct hlist_head *relocation_has=
htable,
> +                                       struct list_head *used_buckets_li=
st)
>  {
>         struct relocation_entry *entry;
>         struct relocation_head *rel_head;
> @@ -661,6 +665,10 @@ int add_relocation_to_accumulate(struct module *me, =
int type, void *location,
>         unsigned long hash;
>
>         entry =3D kmalloc(sizeof(*entry), GFP_KERNEL);
> +
> +       if (!entry)
> +               return -ENOMEM;
> +
>         INIT_LIST_HEAD(&entry->head);
>         entry->type =3D type;
>         entry->value =3D v;
> @@ -669,7 +677,10 @@ int add_relocation_to_accumulate(struct module *me, =
int type, void *location,
>
>         current_head =3D &relocation_hashtable[hash];
>
> -       /* Find matching location (if any) */
> +       /*
> +        * Search for the relocation_head for the relocations that happen=
 at the
> +        * provided location
> +        */
>         bool found =3D false;
>         struct relocation_head *rel_head_iter;
>
> @@ -681,19 +692,45 @@ int add_relocation_to_accumulate(struct module *me,=
 int type, void *location,
>                 }
>         }
>
> +       /*
> +        * If there has not yet been any relocations at the provided loca=
tion,
> +        * create a relocation_head for that location and populate it wit=
h this
> +        * relocation_entry.
> +        */
>         if (!found) {
>                 rel_head =3D kmalloc(sizeof(*rel_head), GFP_KERNEL);
> +
> +               if (!rel_head) {
> +                       kfree(entry);
> +                       return -ENOMEM;
> +               }
> +
>                 rel_head->rel_entry =3D
>                         kmalloc(sizeof(struct list_head), GFP_KERNEL);
> +
> +               if (!rel_head->rel_entry) {
> +                       kfree(entry);
> +                       kfree(rel_head);
> +                       return -ENOMEM;
> +               }
> +
>                 INIT_LIST_HEAD(rel_head->rel_entry);
>                 rel_head->location =3D location;
>                 INIT_HLIST_NODE(&rel_head->node);
>                 if (!current_head->first) {
>                         bucket =3D
>                                 kmalloc(sizeof(struct used_bucket), GFP_K=
ERNEL);
> +
> +                       if (!bucket) {
> +                               kfree(entry);
> +                               kfree(rel_head);
> +                               kfree(rel_head->rel_entry);
> +                               return -ENOMEM;
> +                       }
> +
>                         INIT_LIST_HEAD(&bucket->head);
>                         bucket->bucket =3D current_head;
> -                       list_add(&bucket->head, &used_buckets_list);
> +                       list_add(&bucket->head, used_buckets_list);
>                 }
>                 hlist_add_head(&rel_head->node, current_head);
>         }
> @@ -704,7 +741,9 @@ int add_relocation_to_accumulate(struct module *me, i=
nt type, void *location,
>         return 0;
>  }
>
> -unsigned int initialize_relocation_hashtable(unsigned int num_relocation=
s)
> +static unsigned int
> +initialize_relocation_hashtable(unsigned int num_relocations,
> +                               struct hlist_head **relocation_hashtable)
>  {
>         /* Can safely assume that bits is not greater than sizeof(long) *=
/
>         unsigned long hashtable_size =3D roundup_pow_of_two(num_relocatio=
ns);
> @@ -720,12 +759,13 @@ unsigned int initialize_relocation_hashtable(unsign=
ed int num_relocations)
>
>         hashtable_size <<=3D should_double_size;
>
> -       relocation_hashtable =3D kmalloc_array(hashtable_size,
> -                                            sizeof(*relocation_hashtable=
),
> -                                            GFP_KERNEL);
> -       __hash_init(relocation_hashtable, hashtable_size);
> +       *relocation_hashtable =3D kmalloc_array(hashtable_size,
> +                                             sizeof(*relocation_hashtabl=
e),
> +                                             GFP_KERNEL);
> +       if (!*relocation_hashtable)
> +               return -ENOMEM;
>
> -       INIT_LIST_HEAD(&used_buckets_list);
> +       __hash_init(*relocation_hashtable, hashtable_size);
>
>         return hashtable_bits;
>  }
> @@ -742,7 +782,17 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char=
 *strtab,
>         Elf_Addr v;
>         int res;
>         unsigned int num_relocations =3D sechdrs[relsec].sh_size / sizeof=
(*rel);
> -       unsigned int hashtable_bits =3D initialize_relocation_hashtable(n=
um_relocations);
> +       struct hlist_head *relocation_hashtable;
> +       struct list_head used_buckets_list;
> +       unsigned int hashtable_bits;
> +
> +       hashtable_bits =3D initialize_relocation_hashtable(num_relocation=
s,
> +                                                        &relocation_hash=
table);
> +
> +       if (hashtable_bits < 0)
> +               return hashtable_bits;
> +
> +       INIT_LIST_HEAD(&used_buckets_list);
>
>         pr_debug("Applying relocate section %u to %u\n", relsec,
>                sechdrs[relsec].sh_info);
> @@ -823,14 +873,18 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const cha=
r *strtab,
>                 }
>
>                 if (reloc_handlers[type].accumulate_handler)
> -                       res =3D add_relocation_to_accumulate(me, type, lo=
cation, hashtable_bits, v);
> +                       res =3D add_relocation_to_accumulate(me, type, lo=
cation,
> +                                                          hashtable_bits=
, v,
> +                                                          relocation_has=
htable,
> +                                                          &used_buckets_=
list);
>                 else
>                         res =3D handler(me, location, v);
>                 if (res)
>                         return res;
>         }
>
> -       process_accumulated_relocations(me);
> +       process_accumulated_relocations(me, &relocation_hashtable,
> +                                       &used_buckets_list);
>
>         return 0;
>  }
>
> --
> 2.42.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
