Return-Path: <linux-kernel+bounces-75889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13D085F05A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84B31C2295B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558B0111B2;
	Thu, 22 Feb 2024 04:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQ7MnaFb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15381171AF;
	Thu, 22 Feb 2024 04:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708574844; cv=none; b=f+Eq8maQHxQflYsZIhblsfuu+uI8UizkjEL+psb+9lWSaksyg9/uQY8wOS3y9SdamiThLdh7QKpkGii9BZ82KJbpFaXCqCmaS+AP3fOcNtZukOZey/tBQNKzKNNCaWYuKmEsA0h6WHTohI3l7l+aRwkhCMBtWLKHS3411mV61II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708574844; c=relaxed/simple;
	bh=U315Ak176pxgfgByJBYNXMbGeGy8KeNXicRCtcQvKKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGH90ZEl/XGUJDvWjhLbw9Lf4Yztvb5Q3MTk5jn1tr6aqlCm70M80hj4iG9A7/58XJ+M78eZQgaCnlByV0o7vMW9M+mCqmTU9QtDRNdDqxrfcfZQbYd0sF5Oo/+G1QPo4IyjZRu7O5yuhRmhL5LPd1b3sKrWOJTeh7KvLEiBuAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQ7MnaFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB97C433A6;
	Thu, 22 Feb 2024 04:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708574843;
	bh=U315Ak176pxgfgByJBYNXMbGeGy8KeNXicRCtcQvKKs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lQ7MnaFb9LtdIhgZt0Pfsow6d8g7zgni1ad6PD9MezsmRY//7wWkZ0I1IYn7wjPsx
	 Y6R26xjcuCkxU/fQHYcdur7WiDhuTCYVramRK1t49Td8uYFM4M5aEUKvueaXm7Ajaq
	 /EMlGhXdQZGo78xeO9Jk6JRcRe5qweew/JLt7aR6+rndYHtLskmnT/VovLjEjVOPqj
	 FoYss1uZ5ABC2FcwN92CJUILnIO1469XN04LqVFl4vvaOGnd5pG38v2T20TUEis/8u
	 CNLNb3wSoq6Ld4SYXfF+HBnpmRijDkUrKg4LX3GShWXLruoOn7tEuvrRbae0aS8da+
	 DFWAOxk14257w==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso15287491fa.3;
        Wed, 21 Feb 2024 20:07:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX4O/Ri5RbHsYLl8hot2A/SuMfr0uYy01iZ93cETuxJq1EYjFke5lVpvS1fDP7dlKGl6FNgSfGVX8TvV7O44FVJTO+ZD/hmw6IQdWlFqS8nZBBCDON+WZi2T2n3LAgWyram/5jJH8EMJq/d
X-Gm-Message-State: AOJu0YxVbEXFfsGqK0aoitExqALLp4z5VAmd4Wu2ke1APFnXavmUrSeH
	YtGBuvg1AJr9aqCo1pjnfLDcTco6s8R1bSjCLehWMfxo6lDPsriJD5dLRodeZWU9hyAzKJV/4M8
	E+CwJO0mc8SIbSljLeNj1T55ruvI=
X-Google-Smtp-Source: AGHT+IHue+19wyjIOZWYHsHVY17dawEI+PiGLykMN78RQP3/T+fYNyXmAxXn+HDLm+rju9SM7EJWo701sLUJwJcIrgc=
X-Received: by 2002:a2e:9f4b:0:b0:2d2:3ae4:1cc with SMTP id
 v11-20020a2e9f4b000000b002d23ae401ccmr6408804ljk.6.1708574841659; Wed, 21 Feb
 2024 20:07:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221202655.2423854-1-jannh@google.com> <20240221202655.2423854-2-jannh@google.com>
In-Reply-To: <20240221202655.2423854-2-jannh@google.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 22 Feb 2024 13:06:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQG_dX8p0Lch-wg8cOVRQzaJUh2zFJL+3tgpcT8_iSTow@mail.gmail.com>
Message-ID: <CAK7LNAQG_dX8p0Lch-wg8cOVRQzaJUh2zFJL+3tgpcT8_iSTow@mail.gmail.com>
Subject: Re: [PATCH 2/2] kallsyms: build faster by using .incbin
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Zhen Lei <thunder.leizhen@huawei.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 5:27=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> Currently, kallsyms builds a big assembly file (~19M with a normal
> kernel config), and then the assembler has to turn that big assembly
> file back into binary data, which takes around a second per kallsyms
> invocation. (Normally there are two kallsyms invocations per build.)
>
> It is much faster to instead directly output binary data, which can
> be imported in an assembly file using ".incbin". This is also the
> approach taken by arch/x86/boot/compressed/mkpiggy.c.


Yes, that is a sensible case because it just wraps the binary
without any modification.




> So this patch switches kallsyms to that approach.
>
> A complication with this is that the endianness of numbers between
> host and target might not match (for example, when cross-compiling);
> and there seems to be no kconfig symbol that tells us what endianness
> the target has.



CONFIG_CPU_BIG_ENDIAN is it.



You could do this:

if is_enabled CONFIG_CPU_BIG_ENDIAN; then
        kallsymopt=3D"${kallsymopt} --big-endian"
fi

if is_enabled CONFIG_64BIT; then
        kallsymopt=3D"${kallsymopt} --64bit"
fi






> So pass the path to the intermediate vmlinux ELF file to the kallsyms
> tool, and let it parse the ELF header to figure out the target's
> endianness.
>
> I have verified that running kallsyms without these changes and
> kallsyms with these changes on the same input System.map results
> in identical object files.
>
> This change reduces the time for an incremental kernel rebuild
> (touch fs/ioctl.c, then re-run make) from 27.7s to 24.1s (medians
> over 16 runs each) on my machine - saving around 3.6 seconds.




This reverts bea5b74504742f1b51b815bcaf9a70bddbc49ce3

Somebody might struggle with debugging again, but I am not sure.

Arnd?



If the effort were "I invented a way to do kallsyms in
one pass instead of three", it would be so much more attractive.


I am not so sure if this grain of the optimization is exciting,
but I confirmed that a few seconds were saved for the defconfig.

I am neutral about this.



For the debugging purpose, perhaps we can add --debug option
in order to leave the possibility for
outputting the full assembly as comments.



>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  scripts/kallsyms.c      | 196 ++++++++++++++++++++++++++++++++--------
>  scripts/link-vmlinux.sh |   5 +-
>  2 files changed, 159 insertions(+), 42 deletions(-)
>
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index f35be95adfbe..ef03d723aded 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -27,6 +27,10 @@
>  #include <string.h>
>  #include <ctype.h>
>  #include <limits.h>
> +#include <endian.h>
> +#include <elf.h>
> +#include <fcntl.h>
> +#include <unistd.h>
>
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
>
> @@ -75,7 +79,7 @@ static unsigned char best_table_len[256];
>  static void usage(void)
>  {
>         fprintf(stderr, "Usage: kallsyms [--all-symbols] [--absolute-perc=
pu] "
> -                       "[--lto-clang] in.map > out.S\n");
> +                       "[--lto-clang] in in.map out.S out.bin\n");
>         exit(1);
>  }
>
> @@ -290,20 +294,57 @@ static void read_map(const char *in)
>         fclose(fp);
>  }
>
> +static bool is_64bit, is_little_endian;
> +static char *asm_path, *bin_path;
> +static FILE *asm_file, *bin_file;
> +static size_t bin_offset, bin_included;
> +
>  static void output_label(const char *label)
>  {
> -       printf(".globl %s\n", label);
> -       printf("\tALGN\n");
> -       printf("%s:\n", label);
> +       fprintf(asm_file, ".globl %s\n", label);
> +       fprintf(asm_file, "\tALGN\n");
> +       fprintf(asm_file, "%s:\n", label);
>  }
>
>  /* Provide proper symbols relocatability by their '_text' relativeness. =
*/
>  static void output_address(unsigned long long addr)
>  {
>         if (_text <=3D addr)
> -               printf("\tPTR\t_text + %#llx\n", addr - _text);
> +               fprintf(asm_file, "\tPTR\t_text + %#llx\n", addr - _text)=
;
>         else
> -               printf("\tPTR\t_text - %#llx\n", _text - addr);
> +               fprintf(asm_file, "\tPTR\t_text - %#llx\n", _text - addr)=
;
> +}
> +
> +/*
> + * Include all data that has been written into bin_file since the last c=
all to
> + * this function.
> + */
> +static void include_bin_data(void)
> +{
> +       fprintf(asm_file, ".incbin \"%s\", %zu, %zu\n", bin_path,
> +               bin_included, bin_offset - bin_included);
> +       bin_included =3D bin_offset;
> +}
> +
> +static void output_bin_data(const void *data, size_t len)
> +{
> +       if (fwrite(data, 1, len, bin_file) !=3D len) {
> +               fprintf(stderr, "kallsyms: unable to write output\n");
> +               exit(EXIT_FAILURE);
> +       }
> +       bin_offset +=3D len;
> +}
> +static void output_bin_u32(uint32_t value)
> +{
> +       uint32_t encoded =3D is_little_endian ? htole32(value) : htobe32(=
value);
> +
> +       output_bin_data(&encoded, sizeof(encoded));
> +}
> +static void output_bin_u16(uint16_t value)



You might want to insert a blank line
between functions.





> +{
> +       uint16_t encoded =3D is_little_endian ? htole16(value) : htobe16(=
value);
> +
> +       output_bin_data(&encoded, sizeof(encoded));
>  }
>
>  /* uncompress a compressed symbol. When this function is called, the bes=
t table
> @@ -384,25 +425,36 @@ static void sort_symbols_by_name(void)
>
>  static void write_src(void)
>  {
> -       unsigned int i, k, off;
> +       unsigned int i, off;
>         unsigned int best_idx[256];
>         unsigned int *markers;
>         char buf[KSYM_NAME_LEN];
>
> -       printf("#include <asm/bitsperlong.h>\n");
> -       printf("#if BITS_PER_LONG =3D=3D 64\n");
> -       printf("#define PTR .quad\n");
> -       printf("#define ALGN .balign 8\n");
> -       printf("#else\n");
> -       printf("#define PTR .long\n");
> -       printf("#define ALGN .balign 4\n");
> -       printf("#endif\n");
> +       asm_file =3D fopen(asm_path, "w");
> +       if (!asm_file) {
> +               perror("unable to open asm output");
> +               exit(EXIT_FAILURE);
> +       }
> +       bin_file =3D fopen(bin_path, "w");
> +       if (!bin_file) {
> +               perror("unable to open bin output");
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       fprintf(asm_file, "#include <asm/bitsperlong.h>\n");
> +       fprintf(asm_file, "#if BITS_PER_LONG =3D=3D 64\n");
> +       fprintf(asm_file, "#define PTR .quad\n");
> +       fprintf(asm_file, "#define ALGN .balign 8\n");
> +       fprintf(asm_file, "#else\n");
> +       fprintf(asm_file, "#define PTR .long\n");
> +       fprintf(asm_file, "#define ALGN .balign 4\n");
> +       fprintf(asm_file, "#endif\n");




With this patch, this tool will need to be aware
whether the target is 64-bit or not.

There is no point to include <asm/bitsperlong.h>
to check BITS_PER_LONG.








>
> -       printf("\t.section .rodata, \"a\"\n");
> +       fprintf(asm_file, "\t.section .rodata, \"a\"\n");
>
>         output_label("kallsyms_num_syms");
> -       printf("\t.long\t%u\n", table_cnt);
> -       printf("\n");
> +       fprintf(asm_file, "\t.long\t%u\n", table_cnt);
> +       fprintf(asm_file, "\n");
>
>         /* table of offset markers, that give the offset in the compresse=
d stream
>          * every 256 symbols */
> @@ -437,20 +489,23 @@ static void write_src(void)
>                 /* Encode length with ULEB128. */
>                 if (table[i]->len <=3D 0x7F) {
>                         /* Most symbols use a single byte for the length.=
 */
> -                       printf("\t.byte 0x%02x", table[i]->len);
> +                       unsigned char len_encoded[1] =3D { table[i]->len =
};
> +
> +                       output_bin_data(len_encoded, sizeof(len_encoded))=
;
>                         off +=3D table[i]->len + 1;
>                 } else {
>                         /* "Big" symbols use two bytes. */
> -                       printf("\t.byte 0x%02x, 0x%02x",
> +                       unsigned char len_encoded[2] =3D {
>                                 (table[i]->len & 0x7F) | 0x80,
> -                               (table[i]->len >> 7) & 0x7F);
> +                               (table[i]->len >> 7) & 0x7F
> +                       };
> +
> +                       output_bin_data(len_encoded, sizeof(len_encoded))=
;
>                         off +=3D table[i]->len + 2;
>                 }
> -               for (k =3D 0; k < table[i]->len; k++)
> -                       printf(", 0x%02x", table[i]->sym[k]);
> -               printf("\n");
> +               output_bin_data(table[i]->sym, table[i]->len);
>         }
> -       printf("\n");
> +       include_bin_data();
>
>         /*
>          * Now that we wrote out the compressed symbol names, restore the
> @@ -463,8 +518,8 @@ static void write_src(void)
>
>         output_label("kallsyms_markers");
>         for (i =3D 0; i < ((table_cnt + 255) >> 8); i++)
> -               printf("\t.long\t%u\n", markers[i]);
> -       printf("\n");
> +               output_bin_u32(markers[i]);
> +       include_bin_data();
>
>         free(markers);
>
> @@ -473,15 +528,15 @@ static void write_src(void)
>         for (i =3D 0; i < 256; i++) {
>                 best_idx[i] =3D off;
>                 expand_symbol(best_table[i], best_table_len[i], buf);
> -               printf("\t.asciz\t\"%s\"\n", buf);
> +               output_bin_data(buf, strlen(buf)+1);
>                 off +=3D strlen(buf) + 1;
>         }
> -       printf("\n");
> +       include_bin_data();
>
>         output_label("kallsyms_token_index");
>         for (i =3D 0; i < 256; i++)
> -               printf("\t.short\t%d\n", best_idx[i]);
> -       printf("\n");
> +               output_bin_u16(best_idx[i]);
> +       include_bin_data();
>
>         output_label("kallsyms_offsets");
>
> @@ -513,13 +568,12 @@ static void write_src(void)
>                                 table[i]->addr);
>                         exit(EXIT_FAILURE);
>                 }
> -               printf("\t.long\t%#x    /* %s */\n", (int)offset, table[i=
]->sym);
> +               output_bin_u32((uint32_t)offset);
>         }
> -       printf("\n");
> +       include_bin_data();
>
>         output_label("kallsyms_relative_base");
>         output_address(relative_base);
> -       printf("\n");
>
>         if (lto_clang)
>                 for (i =3D 0; i < table_cnt; i++)
> @@ -527,12 +581,24 @@ static void write_src(void)
>
>         sort_symbols_by_name();
>         output_label("kallsyms_seqs_of_names");
> -       for (i =3D 0; i < table_cnt; i++)
> -               printf("\t.byte 0x%02x, 0x%02x, 0x%02x\n",
> +       for (i =3D 0; i < table_cnt; i++) {
> +               unsigned char seq_encoded[3] =3D {
>                         (unsigned char)(table[i]->seq >> 16),
>                         (unsigned char)(table[i]->seq >> 8),
> -                       (unsigned char)(table[i]->seq >> 0));
> -       printf("\n");
> +                       (unsigned char)(table[i]->seq >> 0)
> +               };
> +               output_bin_data(seq_encoded, sizeof(seq_encoded));
> +       }
> +       include_bin_data();
> +
> +       if (fclose(asm_file)) {
> +               perror("unable to write to asm output");
> +               exit(EXIT_FAILURE);
> +       }
> +       if (fclose(bin_file)) {
> +               perror("unable to write to bin output");
> +               exit(EXIT_FAILURE);
> +       }
>  }
>
>
> @@ -795,6 +861,52 @@ static void record_relative_base(void)
>                 }
>  }
>
> +static void get_target_data_types(const char *elf_path)
> +{
> +       int elf_fd =3D open(elf_path, O_RDONLY);
> +       unsigned char elf_ident[EI_NIDENT];
> +
> +       if (elf_fd =3D=3D -1) {
> +               perror("open ELF");
> +               exit(EXIT_FAILURE);
> +       }
> +       if (read(elf_fd, elf_ident, sizeof(elf_ident)) !=3D sizeof(elf_id=
ent)) {
> +               perror("read ELF header");
> +               exit(EXIT_FAILURE);
> +       }
> +       close(elf_fd);
> +
> +       if (elf_ident[EI_MAG0] !=3D ELFMAG0 || elf_ident[EI_MAG1] !=3D EL=
FMAG1 ||
> +           elf_ident[EI_MAG2] !=3D ELFMAG2 || elf_ident[EI_MAG3] !=3D EL=
FMAG3) {
> +               fprintf(stderr, "kallsyms: input ELF has invalid header\n=
");
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       switch (elf_ident[EI_CLASS]) {
> +       case ELFCLASS32:
> +               is_64bit =3D false;
> +               break;
> +       case ELFCLASS64:
> +               is_64bit =3D true;
> +               break;
> +       default:
> +               fprintf(stderr, "kallsyms: input ELF has invalid bitness\=
n");
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       switch (elf_ident[EI_DATA]) {
> +       case ELFDATA2LSB:
> +               is_little_endian =3D true;
> +               break;
> +       case ELFDATA2MSB:
> +               is_little_endian =3D false;
> +               break;
> +       default:
> +               fprintf(stderr, "kallsyms: input ELF has invalid endianne=
ss\n");
> +               exit(EXIT_FAILURE);
> +       }
> +}
> +
>  int main(int argc, char **argv)
>  {
>         while (1) {
> @@ -813,10 +925,14 @@ int main(int argc, char **argv)
>                         usage();
>         }
>
> -       if (optind >=3D argc)
> +       if (optind+4 !=3D argc)
>                 usage();
> +       asm_path =3D argv[optind+2];
> +       bin_path =3D argv[optind+3];
> +
> +       get_target_data_types(argv[optind]);
>
> -       read_map(argv[optind]);
> +       read_map(argv[optind+1]);
>         shrink_table();
>         if (absolute_percpu)
>                 make_percpus_absolute();
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 5127371d3393..1b5ff33a2d4a 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -162,7 +162,7 @@ kallsyms()
>         fi
>
>         info KSYMS ${2}
> -       scripts/kallsyms ${kallsymopt} ${1} > ${2}
> +       scripts/kallsyms ${kallsymopt} ${1} ${2} ${3} ${4}
>  }
>
>  # Perform one step in kallsyms generation, including temporary linking o=
f
> @@ -173,10 +173,11 @@ kallsyms_step()
>         kallsyms_vmlinux=3D.tmp_vmlinux.kallsyms${1}
>         kallsymso=3D${kallsyms_vmlinux}.o
>         kallsyms_S=3D${kallsyms_vmlinux}.S
> +       kallsyms_bin=3D${kallsyms_vmlinux}.bin
>
>         vmlinux_link ${kallsyms_vmlinux} "${kallsymso_prev}" ${btf_vmlinu=
x_bin_o}
>         mksysmap ${kallsyms_vmlinux} ${kallsyms_vmlinux}.syms ${kallsymso=
_prev}
> -       kallsyms ${kallsyms_vmlinux}.syms ${kallsyms_S}
> +       kallsyms ${kallsyms_vmlinux} ${kallsyms_vmlinux}.syms ${kallsyms_=
S} ${kallsyms_bin}
>
>         info AS ${kallsyms_S}
>         ${CC} ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS} \
> --
> 2.44.0.rc0.258.g7320e95886-goog
>


--=20
Best Regards
Masahiro Yamada

