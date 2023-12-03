Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F1E80255D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 17:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjLCQWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 11:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjLCQWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 11:22:39 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF696CF;
        Sun,  3 Dec 2023 08:22:44 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B3Cj1a6026049;
        Sun, 3 Dec 2023 16:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=hrR0E04K4jQ6RSEtS2yXTgf/Y8O1TDgOz1BThu36R9k=;
 b=W9o639QgdYwdL7glo5x5jV57v73fOnRa6iW5lroLDAo/rxrGTF4HgSFB6SpxkIWGvxdh
 5W5s4+/ZI3mBqlpxIBygwHjdMGM0lLDzZRDGBwMi7B46MyE0X8KUiY2XqOmVHEMY3A2Q
 gkI26f9+63WwZrC1FwUn4XUa1/52axeQffhe4oMO+E8SWvmtA6HN4kiM1OP30bct249k
 cOCkBcRRluk9/aBP89/RxVNUaGVUjp42R0TiCfZtQinyIMoiv1v7Pw8GvQV/PIFe7BkL
 6kxqICXJncjODEzo2Ld8gHYFYY0xOXfDysz8mIFmXWtdkuTxQ1p6pG4cXfb/wQ0VkRhH OA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3urm94y35w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Dec 2023 16:22:24 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B3GIE2K031280;
        Sun, 3 Dec 2023 16:22:24 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3urm94y35n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Dec 2023 16:22:23 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B3EXxtw017899;
        Sun, 3 Dec 2023 16:22:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3urh4k30aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Dec 2023 16:22:22 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B3GMLTp19530292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 3 Dec 2023 16:22:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2275B20043;
        Sun,  3 Dec 2023 16:22:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E03DA20040;
        Sun,  3 Dec 2023 16:22:18 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.33.217])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sun,  3 Dec 2023 16:22:18 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH 36/48] perf annotate-data: Introduce struct data_loc_info
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20231012035111.676789-37-namhyung@kernel.org>
Date:   Sun, 3 Dec 2023 21:52:07 +0530
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <852644CC-CF12-475A-A7D2-84EFDCE9D248@linux.vnet.ibm.com>
References: <20231012035111.676789-1-namhyung@kernel.org>
 <20231012035111.676789-37-namhyung@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: k3zDVTppngeOhuDiMmzLins_WC3PHmKK
X-Proofpoint-GUID: n0vEnUdVeOsr1g5H8P7IP-gZkSfXoBu4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-03_14,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312030130
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 12-Oct-2023, at 9:20=E2=80=AFAM, Namhyung Kim <namhyung@kernel.org> =
wrote:
>=20
> The find_data_type() needs many information to describe the location =
of
> the data.  Add the new struct data_loc_info to pass those information =
at
> once.
>=20
> No functional changes intended.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> tools/perf/util/annotate-data.c | 83 +++++++++++++++++----------------
> tools/perf/util/annotate-data.h | 38 ++++++++++++---
> tools/perf/util/annotate.c      | 30 ++++++------
> 3 files changed, 91 insertions(+), 60 deletions(-)
>=20
> diff --git a/tools/perf/util/annotate-data.c =
b/tools/perf/util/annotate-data.c
> index 39bbd56b2160..90793cbb6aa0 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -256,21 +256,28 @@ static int check_variable(Dwarf_Die *var_die, =
Dwarf_Die *type_die, int offset,
> }
>=20
> /* The result will be saved in @type_die */
> -static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
> -      const char *var_name, struct annotated_op_loc *loc,
> -      Dwarf_Die *type_die)
> +static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die =
*type_die)
> {
> + struct annotated_op_loc *loc =3D dloc->op;
> Dwarf_Die cu_die, var_die;
> Dwarf_Die *scopes =3D NULL;
> int reg, offset;
> int ret =3D -1;
> int i, nr_scopes;
> int fbreg =3D -1;
> - bool is_fbreg =3D false;
> int fb_offset =3D 0;
> + bool is_fbreg =3D false;
> + u64 pc;
> +
> + /*
> + * IP is a relative instruction address from the start of the map, as
> + * it can be randomized/relocated, it needs to translate to PC which =
is
> + * a file address for DWARF processing.
> + */
> + pc =3D map__rip_2objdump(dloc->ms->map, dloc->ip);
>=20
> /* Get a compile_unit for this address */
> - if (!find_cu_die(di, pc, &cu_die)) {
> + if (!find_cu_die(dloc->di, pc, &cu_die)) {
> pr_debug("cannot find CU for address %lx\n", pc);
> ann_data_stat.no_cuinfo++;
> return -1;
> @@ -280,18 +287,19 @@ static int find_data_type_die(struct debuginfo =
*di, u64 pc, u64 addr,
> offset =3D loc->offset;
>=20
> if (reg =3D=3D DWARF_REG_PC) {
> - if (die_find_variable_by_addr(&cu_die, pc, addr, &var_die, &offset)) =
{
> + if (die_find_variable_by_addr(&cu_die, pc, dloc->var_addr,
> +      &var_die, &offset)) {
> ret =3D check_variable(&var_die, type_die, offset,
>     /*is_pointer=3D*/false);
> - loc->offset =3D offset;
> + dloc->type_offset =3D offset;
> goto out;
> }
>=20
> - if (var_name && die_find_variable_at(&cu_die, var_name, pc,
> -     &var_die)) {
> - ret =3D check_variable(&var_die, type_die, 0,
> + if (dloc->var_name &&
> +    die_find_variable_at(&cu_die, dloc->var_name, pc, &var_die)) {
> + ret =3D check_variable(&var_die, type_die, dloc->type_offset,
>     /*is_pointer=3D*/false);
> - /* loc->offset will be updated by the caller */
> + /* dloc->type_offset was updated by the caller */
> goto out;
> }
> }
> @@ -308,10 +316,11 @@ static int find_data_type_die(struct debuginfo =
*di, u64 pc, u64 addr,
>    dwarf_formblock(&attr, &block) =3D=3D 0 && block.length =3D=3D 1) {
> switch (*block.data) {
> case DW_OP_reg0 ... DW_OP_reg31:
> - fbreg =3D *block.data - DW_OP_reg0;
> + fbreg =3D dloc->fbreg =3D *block.data - DW_OP_reg0;
> break;
> case DW_OP_call_frame_cfa:
> - if (die_get_cfa(di->dbg, pc, &fbreg,
> + dloc->fb_cfa =3D true;
> + if (die_get_cfa(dloc->di->dbg, pc, &fbreg,
> &fb_offset) < 0)
> fbreg =3D -1;
> break;
> @@ -329,7 +338,7 @@ static int find_data_type_die(struct debuginfo =
*di, u64 pc, u64 addr,
> /* Search from the inner-most scope to the outer */
> for (i =3D nr_scopes - 1; i >=3D 0; i--) {
> if (reg =3D=3D DWARF_REG_PC) {
> - if (!die_find_variable_by_addr(&scopes[i], pc, addr,
> + if (!die_find_variable_by_addr(&scopes[i], pc, dloc->var_addr,
>       &var_die, &offset))
> continue;
> } else {
> @@ -342,7 +351,7 @@ static int find_data_type_die(struct debuginfo =
*di, u64 pc, u64 addr,
> /* Found a variable, see if it's correct */
> ret =3D check_variable(&var_die, type_die, offset,
>     reg !=3D DWARF_REG_PC && !is_fbreg);
> - loc->offset =3D offset;
> + dloc->type_offset =3D offset;
> goto out;
> }
>=20
> @@ -361,50 +370,46 @@ static int find_data_type_die(struct debuginfo =
*di, u64 pc, u64 addr,
>=20
> /**
>  * find_data_type - Return a data type at the location
> - * @ms: map and symbol at the location
> - * @ip: instruction address of the memory access
> - * @loc: instruction operand location
> - * @addr: data address of the memory access
> - * @var_name: global variable name
> + * @dloc: data location
>  *
>  * This functions searches the debug information of the binary to get =
the data
> - * type it accesses.  The exact location is expressed by (@ip, reg, =
offset)
> - * for pointer variables or (@ip, @addr) for global variables.  Note =
that global
> - * variables might update the @loc->offset after finding the start of =
the variable.
> - * If it cannot find a global variable by address, it tried to fine a =
declaration
> - * of the variable using @var_name.  In that case, @loc->offset won't =
be updated.
> + * type it accesses.  The exact location is expressed by (ip, reg, =
offset)
> + * for pointer variables or (ip, addr) for global variables.  Note =
that global
> + * variables might update the @dloc->type_offset after finding the =
start of the
> + * variable.  If it cannot find a global variable by address, it =
tried to find
> + * a declaration of the variable using var_name.  In that case, =
@dloc->offset
> + * won't be updated.
>  *
>  * It return %NULL if not found.
>  */
> -struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 =
ip,
> -   struct annotated_op_loc *loc, u64 addr,
> -   const char *var_name)
> +struct annotated_data_type *find_data_type(struct data_loc_info =
*dloc)
> {
> struct annotated_data_type *result =3D NULL;
> - struct dso *dso =3D ms->map->dso;
> - struct debuginfo *di;
> + struct dso *dso =3D dloc->ms->map->dso;
> Dwarf_Die type_die;
> - u64 pc;
>=20
> - di =3D debuginfo__new(dso->long_name);
> - if (di =3D=3D NULL) {
> + dloc->di =3D debuginfo__new(dso->long_name);
> + if (dloc->di =3D=3D NULL) {
> pr_debug("cannot get the debug info\n");
> return NULL;
> }
>=20
> /*
> - * IP is a relative instruction address from the start of the map, as
> - * it can be randomized/relocated, it needs to translate to PC which =
is
> - * a file address for DWARF processing.
> + * The type offset is the same as instruction offset by default.
> + * But when finding a global variable, the offset won't be valid.
> */
> - pc =3D map__rip_2objdump(ms->map, ip);
> - if (find_data_type_die(di, pc, addr, var_name, loc, &type_die) < 0)
> + if (dloc->var_name =3D=3D NULL)
> + dloc->type_offset =3D dloc->op->offset;
> +
> + dloc->fbreg =3D -1;
> +
> + if (find_data_type_die(dloc, &type_die) < 0)
> goto out;
>=20
> result =3D dso__findnew_data_type(dso, &type_die);
>=20
> out:
> - debuginfo__delete(di);
> + debuginfo__delete(dloc->di);
> return result;
> }
>=20
> diff --git a/tools/perf/util/annotate-data.h =
b/tools/perf/util/annotate-data.h
> index 1b0db8e8c40e..ad6493ea2c8e 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -8,6 +8,7 @@
> #include <linux/types.h>
>=20
> struct annotated_op_loc;
> +struct debuginfo;
> struct evsel;
> struct map_symbol;
>=20
> @@ -72,6 +73,35 @@ struct annotated_data_type {
> extern struct annotated_data_type unknown_type;
> extern struct annotated_data_type stackop_type;
>=20
> +/**
> + * struct data_loc_info - Data location information
> + * @ms: Map and Symbol info
> + * @ip: Instruction address
> + * @var_addr: Data address (for global variables)
> + * @var_name: Variable name (for global variables)
> + * @op: Instruction operand location (regs and offset)
> + * @di: Debug info
> + * @fbreg: Frame base register
> + * @fb_cfa: Whether the frame needs to check CFA
> + * @type_offset: Final offset in the type
> + */
> +struct data_loc_info {
> + /* These are input field, should be filled by caller */
> + struct map_symbol *ms;
> + u64 ip;
> + u64 var_addr;
> + const char *var_name;
> + struct annotated_op_loc *op;
> +
> + /* These are used internally */
> + struct debuginfo *di;
> + int fbreg;
> + bool fb_cfa;
> +
> + /* This is for the result */
> + int type_offset;
> +};
> +
> /**
>  * struct annotated_data_stat - Debug statistics
>  * @total: Total number of entry
> @@ -106,9 +136,7 @@ extern struct annotated_data_stat ann_data_stat;
> #ifdef HAVE_DWARF_SUPPORT
>=20
> /* Returns data type at the location (ip, reg, offset) */
> -struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 =
ip,
> -   struct annotated_op_loc *loc, u64 addr,
> -   const char *var_name);
> +struct annotated_data_type *find_data_type(struct data_loc_info =
*dloc);
>=20
> /* Update type access histogram at the given offset */
> int annotated_data_type__update_samples(struct annotated_data_type =
*adt,
> @@ -121,9 +149,7 @@ void annotated_data_type__tree_delete(struct =
rb_root *root);
> #else /* HAVE_DWARF_SUPPORT */
>=20
> static inline struct annotated_data_type *
> -find_data_type(struct map_symbol *ms __maybe_unused, u64 ip =
__maybe_unused,
> -       struct annotated_op_loc *loc __maybe_unused,
> -       u64 addr __maybe_unused, const char *var_name __maybe_unused)
> +find_data_type(struct data_loc_info *dloc __maybe_unused)
> {
> return NULL;
> }

Hi Namhyung,

I have a thought there. For the type and typeoff sort keys to work, we =
depend on Dwarf support in perf, right ?
If the perf is built without dwarf support ( either due to older =
elfutils or missing libdw.h ) , find_data_type will return NULL and we =
will get =E2=80=9Cunknown=E2=80=9D for Data Type and Data Type Offset in =
the result.

Can we add a pr_debug line in find_data_type (which is in else part for =
HAVE_DWARF_SUPPORT) so that user can understand if =E2=80=9Cunknown=E2=80=9D=
 is due to missing devel during the build ? Or may be restrict -s =
type,typeoff if dwarf support is missing ?

Thanks
Athira
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index fe0074bb98f0..1cf55f903ee4 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -3744,9 +3744,7 @@ struct annotated_data_type =
*hist_entry__get_data_type(struct hist_entry *he)
> struct annotated_op_loc *op_loc;
> struct annotated_data_type *mem_type;
> struct annotated_item_stat *istat;
> - u64 ip =3D he->ip, addr =3D 0;
> - const char *var_name =3D NULL;
> - int var_offset;
> + u64 ip =3D he->ip;
> int i;
>=20
> ann_data_stat.total++;
> @@ -3794,51 +3792,53 @@ struct annotated_data_type =
*hist_entry__get_data_type(struct hist_entry *he)
> }
>=20
> for_each_insn_op_loc(&loc, i, op_loc) {
> + struct data_loc_info dloc =3D {
> + .ms =3D ms,
> + /* Recalculate IP for LOCK prefix or insn fusion */
> + .ip =3D ms->sym->start + dl->al.offset,
> + .op =3D op_loc,
> + };
> +
> if (!op_loc->mem_ref)
> continue;
>=20
> /* Recalculate IP because of LOCK prefix or insn fusion */
> ip =3D ms->sym->start + dl->al.offset;
>=20
> - var_offset =3D op_loc->offset;
> -
> /* PC-relative addressing */
> if (op_loc->reg1 =3D=3D DWARF_REG_PC) {
> struct addr_location al;
> struct symbol *var;
> u64 map_addr;
>=20
> - addr =3D annotate_calc_pcrel(ms, ip, op_loc->offset, dl);
> + dloc.var_addr =3D annotate_calc_pcrel(ms, ip, op_loc->offset, dl);
> /* Kernel symbols might be relocated */
> - map_addr =3D addr + map__reloc(ms->map);
> + map_addr =3D dloc.var_addr + map__reloc(ms->map);
>=20
> addr_location__init(&al);
> var =3D thread__find_symbol_fb(he->thread, he->cpumode,
>     map_addr, &al);
> if (var) {
> - var_name =3D var->name;
> + dloc.var_name =3D var->name;
> /* Calculate type offset from the start of variable */
> - var_offset =3D map_addr - map__unmap_ip(al.map, var->start);
> + dloc.type_offset =3D map_addr - map__unmap_ip(al.map, var->start);
> }
> addr_location__exit(&al);
> }
>=20
> - mem_type =3D find_data_type(ms, ip, op_loc, addr, var_name);
> + mem_type =3D find_data_type(&dloc);
> if (mem_type)
> istat->good++;
> else
> istat->bad++;
>=20
> - if (mem_type && var_name)
> - op_loc->offset =3D var_offset;
> -
> if (symbol_conf.annotate_data_sample) {
> annotated_data_type__update_samples(mem_type, evsel,
> -    op_loc->offset,
> +    dloc.type_offset,
>    he->stat.nr_events,
>    he->stat.period);
> }
> - he->mem_type_off =3D op_loc->offset;
> + he->mem_type_off =3D dloc.type_offset;
> return mem_type;
> }
>=20
> --=20
> 2.42.0.655.g421f12c284-goog
>=20

