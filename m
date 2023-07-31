Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378EF76910F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjGaJFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjGaJFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:05:30 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96DDE57
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:04:24 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-78666f06691so177611739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690794264; x=1691399064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGB1XJU1tKTbmm34WRaI3JWUulXgyOaLebH2EKlwpOg=;
        b=gAJlBLvoevVY9UlnkSn7har2Dn1teLXV0ms7xBQEY2/kb468rfhKybrJF2QJdNP8S7
         RF/nXaOZoEpaT4QrBcKXL1JqL3PtsRjkpDG78+bkQJVHGGHyoFXh6v5qUrza6u5zIg4v
         +KNZPTCTjkIL0I78STFD87rhsfMyyIYqruiXKrX4PcZm2cXEdQ99Z1R67iJVQAIU746i
         ZUbmBcIT7Qy1vSCfwN2vb3yVj8EV8IGDdcUJ1ZPOiDbSSZUpnsOImxOFpmHLHQHV8SQS
         zObh4/iAQI6ZCpzgObjfAP7XLSQ7iRO65qxOAQkf6OSZnneT/F8DSlGUxjHD8YN2T02v
         3UHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690794264; x=1691399064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGB1XJU1tKTbmm34WRaI3JWUulXgyOaLebH2EKlwpOg=;
        b=Zo/Bc2qNCekAgWPnsdVRrOY9kaiFm727G3MoF/wLlmFJ5DQF/e4KckGMBWCyjYN6yK
         agwSHNoD6upnDwyvyoqXhIby319iGQazovfy9RMcOeiQDAhws+jeuPdh2VrEUUn0HTUM
         rsbzZCwXSE6zAeMtWhpFOLNnDFJ6ouIXzpBMUDkCtaMrvY4RB7EI/y2Y/10QMX2lHsgZ
         nSqdEjDzaZQRHqhxmtllJhqgZ6PHQIX8kxR2QH3KdepgyHsOqpPy30eR7hYRBawPQCNJ
         /ZF/x65qryhGPeiLWuZU17ZdOR9s4EGbL8zfOmjcdW7EQa1ZGNNhCY/OL9LvUF6qpNLk
         ldJw==
X-Gm-Message-State: ABy/qLa/e17bUXRI9dRCHaJexFzm2pN8jqestChHFOS6rOKWUU/GE9l2
        D4eSMMExiUNFHX81dkBc1PCG47SmRjuUm2KTs8kV+A==
X-Google-Smtp-Source: APBJJlEbF0stwRnkJb/IQTlY0cZitAAr/Oi+AxwuDTJ0uflSNdwDDPEo2tmgYR1HLcPaGkTOqxHjc47uwVEB1zloKtc=
X-Received: by 2002:a05:6e02:148c:b0:348:c8d6:bc87 with SMTP id
 n12-20020a056e02148c00b00348c8d6bc87mr10033729ilk.27.1690794263545; Mon, 31
 Jul 2023 02:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <aa28455e21f606e6ba7e63268b538d558bcac9a9.1689792825.git.tjeznach@rivosinc.com>
In-Reply-To: <aa28455e21f606e6ba7e63268b538d558bcac9a9.1689792825.git.tjeznach@rivosinc.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 31 Jul 2023 17:04:12 +0800
Message-ID: <CANXhq0r1WDRc6fkgUkxJJnxKRuABvK6rdnLoZy7DngYVxV8gpA@mail.gmail.com>
Subject: Re: [PATCH 09/11] RISC-V: drivers/iommu/riscv: Add SVA with
 PASID/ATS/PRI support.
To:     Tomasz Jeznach <tjeznach@rivosinc.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
        linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
        iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 3:35=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosinc.c=
om> wrote:
>
> Introduces SVA (Shared Virtual Address) for RISC-V IOMMU, with
> ATS/PRI services for capable devices.
>
> Co-developed-by: Sebastien Boeuf <seb@rivosinc.com>
> Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>  drivers/iommu/riscv/iommu.c | 601 +++++++++++++++++++++++++++++++++++-
>  drivers/iommu/riscv/iommu.h |  14 +
>  2 files changed, 610 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 2ef6952a2109..6042c35be3ca 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -384,6 +384,89 @@ static inline void riscv_iommu_cmd_iodir_set_did(str=
uct riscv_iommu_command *cmd
>             FIELD_PREP(RISCV_IOMMU_CMD_IODIR_DID, devid) | RISCV_IOMMU_CM=
D_IODIR_DV;
>  }
>
> +static inline void riscv_iommu_cmd_iodir_set_pid(struct riscv_iommu_comm=
and *cmd,
> +                                                unsigned pasid)
> +{
> +       cmd->dword0 |=3D FIELD_PREP(RISCV_IOMMU_CMD_IODIR_PID, pasid);
> +}
> +
> +static void riscv_iommu_cmd_ats_inval(struct riscv_iommu_command *cmd)
> +{
> +       cmd->dword0 =3D FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CM=
D_ATS_OPCODE) |
> +           FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_ATS_FUNC_INV=
AL);
> +       cmd->dword1 =3D 0;
> +}
> +
> +static inline void riscv_iommu_cmd_ats_prgr(struct riscv_iommu_command *=
cmd)
> +{
> +       cmd->dword0 =3D FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CM=
D_ATS_OPCODE) |
> +           FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_ATS_FUNC_PRG=
R);
> +       cmd->dword1 =3D 0;
> +}
> +
> +static void riscv_iommu_cmd_ats_set_rid(struct riscv_iommu_command *cmd,=
 u32 rid)
> +{
> +       cmd->dword0 |=3D FIELD_PREP(RISCV_IOMMU_CMD_ATS_RID, rid);
> +}
> +
> +static void riscv_iommu_cmd_ats_set_pid(struct riscv_iommu_command *cmd,=
 u32 pid)
> +{
> +       cmd->dword0 |=3D FIELD_PREP(RISCV_IOMMU_CMD_ATS_PID, pid) | RISCV=
_IOMMU_CMD_ATS_PV;
> +}
> +
> +static void riscv_iommu_cmd_ats_set_dseg(struct riscv_iommu_command *cmd=
, u8 seg)
> +{
> +       cmd->dword0 |=3D FIELD_PREP(RISCV_IOMMU_CMD_ATS_DSEG, seg) | RISC=
V_IOMMU_CMD_ATS_DSV;
> +}
> +
> +static void riscv_iommu_cmd_ats_set_payload(struct riscv_iommu_command *=
cmd, u64 payload)
> +{
> +       cmd->dword1 =3D payload;
> +}
> +
> +/* Prepare the ATS invalidation payload */
> +static unsigned long riscv_iommu_ats_inval_payload(unsigned long start,
> +                                                  unsigned long end, boo=
l global_inv)
> +{
> +       size_t len =3D end - start + 1;
> +       unsigned long payload =3D 0;
> +
> +       /*
> +        * PCI Express specification
> +        * Section 10.2.3.2 Translation Range Size (S) Field
> +        */
> +       if (len < PAGE_SIZE)
> +               len =3D PAGE_SIZE;
> +       else
> +               len =3D __roundup_pow_of_two(len);
> +
> +       payload =3D (start & ~(len - 1)) | (((len - 1) >> 12) << 11);
> +
> +       if (global_inv)
> +               payload |=3D RISCV_IOMMU_CMD_ATS_INVAL_G;
> +
> +       return payload;
> +}
> +
> +/* Prepare the ATS invalidation payload for all translations to be inval=
idated. */
> +static unsigned long riscv_iommu_ats_inval_all_payload(bool global_inv)
> +{
> +       unsigned long payload =3D GENMASK_ULL(62, 11);
> +
> +       if (global_inv)
> +               payload |=3D RISCV_IOMMU_CMD_ATS_INVAL_G;
> +
> +       return payload;
> +}
> +
> +/* Prepare the ATS "Page Request Group Response" payload */
> +static unsigned long riscv_iommu_ats_prgr_payload(u16 dest_id, u8 resp_c=
ode, u16 grp_idx)
> +{
> +       return FIELD_PREP(RISCV_IOMMU_CMD_ATS_PRGR_DST_ID, dest_id) |
> +           FIELD_PREP(RISCV_IOMMU_CMD_ATS_PRGR_RESP_CODE, resp_code) |
> +           FIELD_PREP(RISCV_IOMMU_CMD_ATS_PRGR_PRG_INDEX, grp_idx);
> +}
> +
>  /* TODO: Convert into lock-less MPSC implementation. */
>  static bool riscv_iommu_post_sync(struct riscv_iommu_device *iommu,
>                                   struct riscv_iommu_command *cmd, bool s=
ync)
> @@ -460,6 +543,16 @@ static bool riscv_iommu_iodir_inv_devid(struct riscv=
_iommu_device *iommu, unsign
>         return riscv_iommu_post(iommu, &cmd);
>  }
>
> +static bool riscv_iommu_iodir_inv_pasid(struct riscv_iommu_device *iommu=
,
> +                                       unsigned devid, unsigned pasid)
> +{
> +       struct riscv_iommu_command cmd;
> +       riscv_iommu_cmd_iodir_inval_pdt(&cmd);
> +       riscv_iommu_cmd_iodir_set_did(&cmd, devid);
> +       riscv_iommu_cmd_iodir_set_pid(&cmd, pasid);
> +       return riscv_iommu_post(iommu, &cmd);
> +}
> +
>  static bool riscv_iommu_iofence_sync(struct riscv_iommu_device *iommu)
>  {
>         struct riscv_iommu_command cmd;
> @@ -467,6 +560,62 @@ static bool riscv_iommu_iofence_sync(struct riscv_io=
mmu_device *iommu)
>         return riscv_iommu_post_sync(iommu, &cmd, true);
>  }
>
> +static void riscv_iommu_mm_invalidate(struct mmu_notifier *mn,
> +                                     struct mm_struct *mm, unsigned long=
 start,
> +                                     unsigned long end)
> +{
> +       struct riscv_iommu_command cmd;
> +       struct riscv_iommu_endpoint *endpoint;
> +       struct riscv_iommu_domain *domain =3D
> +           container_of(mn, struct riscv_iommu_domain, mn);
> +       unsigned long iova;
> +       /*
> +        * The mm_types defines vm_end as the first byte after the end ad=
dress,
> +        * different from IOMMU subsystem using the last address of an ad=
dress
> +        * range. So do a simple translation here by updating what end me=
ans.
> +        */
> +       unsigned long payload =3D riscv_iommu_ats_inval_payload(start, en=
d - 1, true);
> +
> +       riscv_iommu_cmd_inval_vma(&cmd);
> +       riscv_iommu_cmd_inval_set_gscid(&cmd, 0);
> +       riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
> +       if (end > start) {
> +               /* Cover only the range that is needed */
> +               for (iova =3D start; iova < end; iova +=3D PAGE_SIZE) {
> +                       riscv_iommu_cmd_inval_set_addr(&cmd, iova);
> +                       riscv_iommu_post(domain->iommu, &cmd);
> +               }
> +       } else {
> +               riscv_iommu_post(domain->iommu, &cmd);
> +       }
> +
> +       riscv_iommu_iofence_sync(domain->iommu);
> +
> +       /* ATS invalidation for every device and for specific translation=
 range. */
> +       list_for_each_entry(endpoint, &domain->endpoints, domain) {
> +               if (!endpoint->pasid_enabled)
> +                       continue;
> +
> +               riscv_iommu_cmd_ats_inval(&cmd);
> +               riscv_iommu_cmd_ats_set_dseg(&cmd, endpoint->domid);
> +               riscv_iommu_cmd_ats_set_rid(&cmd, endpoint->devid);
> +               riscv_iommu_cmd_ats_set_pid(&cmd, domain->pasid);
> +               riscv_iommu_cmd_ats_set_payload(&cmd, payload);
> +               riscv_iommu_post(domain->iommu, &cmd);
> +       }
> +       riscv_iommu_iofence_sync(domain->iommu);
> +}
> +
> +static void riscv_iommu_mm_release(struct mmu_notifier *mn, struct mm_st=
ruct *mm)
> +{
> +       /* TODO: removed from notifier, cleanup PSCID mapping, flush IOTL=
B */
> +}
> +
> +static const struct mmu_notifier_ops riscv_iommu_mmuops =3D {
> +       .release =3D riscv_iommu_mm_release,
> +       .invalidate_range =3D riscv_iommu_mm_invalidate,
> +};
> +
>  /* Command queue primary interrupt handler */
>  static irqreturn_t riscv_iommu_cmdq_irq_check(int irq, void *data)
>  {
> @@ -608,6 +757,128 @@ static void riscv_iommu_add_device(struct riscv_iom=
mu_device *iommu, struct devi
>         mutex_unlock(&iommu->eps_mutex);
>  }
>
> +/*
> + * Get device reference based on device identifier (requester id).
> + * Decrement reference count with put_device() call.
> + */
> +static struct device *riscv_iommu_get_device(struct riscv_iommu_device *=
iommu,
> +                                            unsigned devid)
> +{
> +       struct rb_node *node;
> +       struct riscv_iommu_endpoint *ep;
> +       struct device *dev =3D NULL;
> +
> +       mutex_lock(&iommu->eps_mutex);
> +
> +       node =3D iommu->eps.rb_node;
> +       while (node && !dev) {
> +               ep =3D rb_entry(node, struct riscv_iommu_endpoint, node);
> +               if (ep->devid < devid)
> +                       node =3D node->rb_right;
> +               else if (ep->devid > devid)
> +                       node =3D node->rb_left;
> +               else
> +                       dev =3D get_device(ep->dev);
> +       }
> +
> +       mutex_unlock(&iommu->eps_mutex);
> +
> +       return dev;
> +}
> +
> +static int riscv_iommu_ats_prgr(struct device *dev, struct iommu_page_re=
sponse *msg)
> +{
> +       struct riscv_iommu_endpoint *ep =3D dev_iommu_priv_get(dev);
> +       struct riscv_iommu_command cmd;
> +       u8 resp_code;
> +       unsigned long payload;
> +
> +       switch (msg->code) {
> +       case IOMMU_PAGE_RESP_SUCCESS:
> +               resp_code =3D 0b0000;
> +               break;
> +       case IOMMU_PAGE_RESP_INVALID:
> +               resp_code =3D 0b0001;
> +               break;
> +       case IOMMU_PAGE_RESP_FAILURE:
> +               resp_code =3D 0b1111;
> +               break;
> +       }
> +       payload =3D riscv_iommu_ats_prgr_payload(ep->devid, resp_code, ms=
g->grpid);
> +
> +       /* ATS Page Request Group Response */
> +       riscv_iommu_cmd_ats_prgr(&cmd);
> +       riscv_iommu_cmd_ats_set_dseg(&cmd, ep->domid);
> +       riscv_iommu_cmd_ats_set_rid(&cmd, ep->devid);
> +       if (msg->flags & IOMMU_PAGE_RESP_PASID_VALID)
> +               riscv_iommu_cmd_ats_set_pid(&cmd, msg->pasid);
> +       riscv_iommu_cmd_ats_set_payload(&cmd, payload);
> +       riscv_iommu_post(ep->iommu, &cmd);
> +
> +       return 0;
> +}
> +
> +static void riscv_iommu_page_request(struct riscv_iommu_device *iommu,
> +                                    struct riscv_iommu_pq_record *req)
> +{
> +       struct iommu_fault_event event =3D { 0 };
> +       struct iommu_fault_page_request *prm =3D &event.fault.prm;
> +       int ret;
> +       struct device *dev;
> +       unsigned devid =3D FIELD_GET(RISCV_IOMMU_PREQ_HDR_DID, req->hdr);
> +
> +       /* Ignore PGR Stop marker. */
> +       if ((req->payload & RISCV_IOMMU_PREQ_PAYLOAD_M) =3D=3D RISCV_IOMM=
U_PREQ_PAYLOAD_L)
> +               return;
> +
> +       dev =3D riscv_iommu_get_device(iommu, devid);
> +       if (!dev) {
> +               /* TODO: Handle invalid page request */
> +               return;
> +       }
> +
> +       event.fault.type =3D IOMMU_FAULT_PAGE_REQ;
> +
> +       if (req->payload & RISCV_IOMMU_PREQ_PAYLOAD_L)
> +               prm->flags |=3D IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
> +       if (req->payload & RISCV_IOMMU_PREQ_PAYLOAD_W)
> +               prm->perm |=3D IOMMU_FAULT_PERM_WRITE;
> +       if (req->payload & RISCV_IOMMU_PREQ_PAYLOAD_R)
> +               prm->perm |=3D IOMMU_FAULT_PERM_READ;
> +
> +       prm->grpid =3D FIELD_GET(RISCV_IOMMU_PREQ_PRG_INDEX, req->payload=
);
> +       prm->addr =3D FIELD_GET(RISCV_IOMMU_PREQ_UADDR, req->payload) << =
PAGE_SHIFT;
> +
> +       if (req->hdr & RISCV_IOMMU_PREQ_HDR_PV) {
> +               prm->flags |=3D IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> +               /* TODO: where to find this bit */
> +               prm->flags |=3D IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
> +               prm->pasid =3D FIELD_GET(RISCV_IOMMU_PREQ_HDR_PID, req->h=
dr);
> +       }
> +
> +       ret =3D iommu_report_device_fault(dev, &event);
> +       if (ret) {
> +               struct iommu_page_response resp =3D {
> +                       .grpid =3D prm->grpid,
> +                       .code =3D IOMMU_PAGE_RESP_FAILURE,
> +               };
> +               if (prm->flags & IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID) {
> +                       resp.flags |=3D IOMMU_PAGE_RESP_PASID_VALID;
> +                       resp.pasid =3D prm->pasid;
> +               }
> +               riscv_iommu_ats_prgr(dev, &resp);
> +       }
> +
> +       put_device(dev);
> +}
> +
> +static int riscv_iommu_page_response(struct device *dev,
> +                                    struct iommu_fault_event *evt,
> +                                    struct iommu_page_response *msg)
> +{
> +       return riscv_iommu_ats_prgr(dev, msg);
> +}
> +
>  /* Page request interface queue primary interrupt handler */
>  static irqreturn_t riscv_iommu_priq_irq_check(int irq, void *data)
>  {
> @@ -626,7 +897,7 @@ static irqreturn_t riscv_iommu_priq_process(int irq, =
void *data)
>         struct riscv_iommu_queue *q =3D (struct riscv_iommu_queue *)data;
>         struct riscv_iommu_device *iommu;
>         struct riscv_iommu_pq_record *requests;
> -       unsigned cnt, idx, ctrl;
> +       unsigned cnt, len, idx, ctrl;
>
>         iommu =3D container_of(q, struct riscv_iommu_device, priq);
>         requests =3D (struct riscv_iommu_pq_record *)q->base;
> @@ -649,7 +920,8 @@ static irqreturn_t riscv_iommu_priq_process(int irq, =
void *data)
>                 cnt =3D riscv_iommu_queue_consume(iommu, q, &idx);
>                 if (!cnt)
>                         break;
> -               dev_warn(iommu->dev, "unexpected %u page requests\n", cnt=
);
> +               for (len =3D 0; len < cnt; idx++, len++)
> +                       riscv_iommu_page_request(iommu, &requests[idx]);
>                 riscv_iommu_queue_release(iommu, q, cnt);
>         } while (1);
>
> @@ -660,6 +932,169 @@ static irqreturn_t riscv_iommu_priq_process(int irq=
, void *data)
>   * Endpoint management
>   */
>
> +/* Endpoint features/capabilities */
> +static void riscv_iommu_disable_ep(struct riscv_iommu_endpoint *ep)
> +{
> +       struct pci_dev *pdev;
> +
> +       if (!dev_is_pci(ep->dev))
> +               return;
> +
> +       pdev =3D to_pci_dev(ep->dev);
> +
> +       if (ep->pasid_enabled) {
> +               pci_disable_ats(pdev);
> +               pci_disable_pri(pdev);
> +               pci_disable_pasid(pdev);
> +               ep->pasid_enabled =3D false;
> +       }
> +}
> +
> +static void riscv_iommu_enable_ep(struct riscv_iommu_endpoint *ep)
> +{
> +       int rc, feat, num;
> +       struct pci_dev *pdev;
> +       struct device *dev =3D ep->dev;
> +
> +       if (!dev_is_pci(dev))
> +               return;
> +
> +       if (!ep->iommu->iommu.max_pasids)
> +               return;
> +
> +       pdev =3D to_pci_dev(dev);
> +
> +       if (!pci_ats_supported(pdev))
> +               return;
> +
> +       if (!pci_pri_supported(pdev))
> +               return;
> +
> +       feat =3D pci_pasid_features(pdev);
> +       if (feat < 0)
> +               return;
> +
> +       num =3D pci_max_pasids(pdev);
> +       if (!num) {
> +               dev_warn(dev, "Can't enable PASID (num: %d)\n", num);
> +               return;
> +       }
> +
> +       if (num > ep->iommu->iommu.max_pasids)
> +               num =3D ep->iommu->iommu.max_pasids;
> +
> +       rc =3D pci_enable_pasid(pdev, feat);
> +       if (rc) {
> +               dev_warn(dev, "Can't enable PASID (rc: %d)\n", rc);
> +               return;
> +       }
> +
> +       rc =3D pci_reset_pri(pdev);
> +       if (rc) {
> +               dev_warn(dev, "Can't reset PRI (rc: %d)\n", rc);
> +               pci_disable_pasid(pdev);
> +               return;
> +       }
> +
> +       /* TODO: Get supported PRI queue length, hard-code to 32 entries =
*/
> +       rc =3D pci_enable_pri(pdev, 32);
> +       if (rc) {
> +               dev_warn(dev, "Can't enable PRI (rc: %d)\n", rc);
> +               pci_disable_pasid(pdev);
> +               return;
> +       }
> +
> +       rc =3D pci_enable_ats(pdev, PAGE_SHIFT);
> +       if (rc) {
> +               dev_warn(dev, "Can't enable ATS (rc: %d)\n", rc);
> +               pci_disable_pri(pdev);
> +               pci_disable_pasid(pdev);
> +               return;
> +       }
> +
> +       ep->pc =3D (struct riscv_iommu_pc *)get_zeroed_page(GFP_KERNEL);
> +       if (!ep->pc) {
> +               pci_disable_ats(pdev);
> +               pci_disable_pri(pdev);
> +               pci_disable_pasid(pdev);
> +               return;
> +       }
> +
> +       ep->pasid_enabled =3D true;
> +       ep->pasid_feat =3D feat;
> +       ep->pasid_bits =3D ilog2(num);
> +
> +       dev_dbg(ep->dev, "PASID/ATS support enabled, %d bits\n", ep->pasi=
d_bits);
> +}
> +
> +static int riscv_iommu_enable_sva(struct device *dev)
> +{
> +       int ret;
> +       struct riscv_iommu_endpoint *ep =3D dev_iommu_priv_get(dev);
> +
> +       if (!ep || !ep->iommu || !ep->iommu->pq_work)
> +               return -EINVAL;
> +
> +       if (!ep->pasid_enabled)
> +               return -ENODEV;
> +
> +       ret =3D iopf_queue_add_device(ep->iommu->pq_work, dev);
> +       if (ret)
> +               return ret;
> +
> +       return iommu_register_device_fault_handler(dev, iommu_queue_iopf,=
 dev);
> +}
> +
> +static int riscv_iommu_disable_sva(struct device *dev)
> +{
> +       int ret;
> +       struct riscv_iommu_endpoint *ep =3D dev_iommu_priv_get(dev);
> +
> +       ret =3D iommu_unregister_device_fault_handler(dev);
> +       if (!ret)
> +               ret =3D iopf_queue_remove_device(ep->iommu->pq_work, dev)=
;
> +
> +       return ret;
> +}
> +
> +static int riscv_iommu_enable_iopf(struct device *dev)
> +{
> +       struct riscv_iommu_endpoint *ep =3D dev_iommu_priv_get(dev);
> +
> +       if (ep && ep->pasid_enabled)
> +               return 0;
> +
> +       return -EINVAL;
> +}
> +
> +static int riscv_iommu_dev_enable_feat(struct device *dev, enum iommu_de=
v_features feat)
> +{
> +       switch (feat) {
> +       case IOMMU_DEV_FEAT_IOPF:
> +               return riscv_iommu_enable_iopf(dev);
> +
> +       case IOMMU_DEV_FEAT_SVA:
> +               return riscv_iommu_enable_sva(dev);
> +
> +       default:
> +               return -ENODEV;
> +       }
> +}
> +
> +static int riscv_iommu_dev_disable_feat(struct device *dev, enum iommu_d=
ev_features feat)
> +{
> +       switch (feat) {
> +       case IOMMU_DEV_FEAT_IOPF:
> +               return 0;
> +
> +       case IOMMU_DEV_FEAT_SVA:
> +               return riscv_iommu_disable_sva(dev);
> +
> +       default:
> +               return -ENODEV;
> +       }
> +}
> +
>  static int riscv_iommu_of_xlate(struct device *dev, struct of_phandle_ar=
gs *args)
>  {
>         return iommu_fwspec_add_ids(dev, args->args, 1);
> @@ -812,6 +1247,7 @@ static struct iommu_device *riscv_iommu_probe_device=
(struct device *dev)
>
>         dev_iommu_priv_set(dev, ep);
>         riscv_iommu_add_device(iommu, dev);
> +       riscv_iommu_enable_ep(ep);
>
>         return &iommu->iommu;
>  }
> @@ -843,6 +1279,8 @@ static void riscv_iommu_release_device(struct device=
 *dev)
>                 riscv_iommu_iodir_inv_devid(iommu, ep->devid);
>         }
>
> +       riscv_iommu_disable_ep(ep);
> +
>         /* Remove endpoint from IOMMU tracking structures */
>         mutex_lock(&iommu->eps_mutex);
>         rb_erase(&ep->node, &iommu->eps);
> @@ -878,7 +1316,8 @@ static struct iommu_domain *riscv_iommu_domain_alloc=
(unsigned type)
>             type !=3D IOMMU_DOMAIN_DMA_FQ &&
>             type !=3D IOMMU_DOMAIN_UNMANAGED &&
>             type !=3D IOMMU_DOMAIN_IDENTITY &&
> -           type !=3D IOMMU_DOMAIN_BLOCKED)
> +           type !=3D IOMMU_DOMAIN_BLOCKED &&
> +           type !=3D IOMMU_DOMAIN_SVA)
>                 return NULL;
>
>         domain =3D kzalloc(sizeof(*domain), GFP_KERNEL);
> @@ -906,6 +1345,9 @@ static void riscv_iommu_domain_free(struct iommu_dom=
ain *iommu_domain)
>                 pr_warn("IOMMU domain is not empty!\n");
>         }
>
> +       if (domain->mn.ops && iommu_domain->mm)
> +               mmu_notifier_unregister(&domain->mn, iommu_domain->mm);
> +
>         if (domain->pgtbl.cookie)
>                 free_io_pgtable_ops(&domain->pgtbl.ops);
>
> @@ -1023,14 +1465,29 @@ static int riscv_iommu_attach_dev(struct iommu_do=
main *iommu_domain, struct devi
>          */
>         val =3D FIELD_PREP(RISCV_IOMMU_DC_TA_PSCID, domain->pscid);
>
> -       dc->ta =3D cpu_to_le64(val);
> -       dc->fsc =3D cpu_to_le64(riscv_iommu_domain_atp(domain));
> +       if (ep->pasid_enabled) {
> +               ep->pc[0].ta =3D cpu_to_le64(val | RISCV_IOMMU_PC_TA_V);
> +               ep->pc[0].fsc =3D cpu_to_le64(riscv_iommu_domain_atp(doma=
in));
> +               dc->ta =3D 0;
> +               dc->fsc =3D cpu_to_le64(virt_to_pfn(ep->pc) |
> +                   FIELD_PREP(RISCV_IOMMU_DC_FSC_MODE, RISCV_IOMMU_DC_FS=
C_PDTP_MODE_PD8));

Could I know why we determinate to use PD8 directly? Rather than PD17 or PD=
20.

> +       } else {
> +               dc->ta =3D cpu_to_le64(val);
> +               dc->fsc =3D cpu_to_le64(riscv_iommu_domain_atp(domain));
> +       }
>
>         wmb();
>
>         /* Mark device context as valid, synchronise device context cache=
. */
>         val =3D RISCV_IOMMU_DC_TC_V;
>
> +       if (ep->pasid_enabled) {
> +               val |=3D RISCV_IOMMU_DC_TC_EN_ATS |
> +                      RISCV_IOMMU_DC_TC_EN_PRI |
> +                      RISCV_IOMMU_DC_TC_DPE |
> +                      RISCV_IOMMU_DC_TC_PDTV;
> +       }
> +
>         if (ep->iommu->cap & RISCV_IOMMU_CAP_AMO) {
>                 val |=3D RISCV_IOMMU_DC_TC_GADE |
>                        RISCV_IOMMU_DC_TC_SADE;
> @@ -1051,13 +1508,107 @@ static int riscv_iommu_attach_dev(struct iommu_d=
omain *iommu_domain, struct devi
>         return 0;
>  }
>
> +static int riscv_iommu_set_dev_pasid(struct iommu_domain *iommu_domain,
> +                                    struct device *dev, ioasid_t pasid)
> +{
> +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
> +       struct riscv_iommu_endpoint *ep =3D dev_iommu_priv_get(dev);
> +       u64 ta, fsc;
> +
> +       if (!iommu_domain || !iommu_domain->mm)
> +               return -EINVAL;
> +
> +       /* Driver uses TC.DPE mode, PASID #0 is incorrect. */
> +       if (pasid =3D=3D 0)
> +               return -EINVAL;
> +
> +       /* Incorrect domain identifier */
> +       if ((int)domain->pscid < 0)
> +               return -ENOMEM;
> +
> +       /* Process Context table should be set for pasid enabled endpoint=
s. */
> +       if (!ep || !ep->pasid_enabled || !ep->dc || !ep->pc)
> +               return -ENODEV;
> +
> +       domain->pasid =3D pasid;
> +       domain->iommu =3D ep->iommu;
> +       domain->mn.ops =3D &riscv_iommu_mmuops;
> +
> +       /* register mm notifier */
> +       if (mmu_notifier_register(&domain->mn, iommu_domain->mm))
> +               return -ENODEV;
> +
> +       /* TODO: get SXL value for the process, use 32 bit or SATP mode *=
/
> +       fsc =3D virt_to_pfn(iommu_domain->mm->pgd) | satp_mode;
> +       ta =3D RISCV_IOMMU_PC_TA_V | FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, =
domain->pscid);
> +
> +       fsc =3D le64_to_cpu(xchg_relaxed(&(ep->pc[pasid].fsc), cpu_to_le6=
4(fsc)));
> +       ta =3D le64_to_cpu(xchg_relaxed(&(ep->pc[pasid].ta), cpu_to_le64(=
ta)));
> +
> +       wmb();
> +
> +       if (ta & RISCV_IOMMU_PC_TA_V) {
> +               riscv_iommu_iodir_inv_pasid(ep->iommu, ep->devid, pasid);
> +               riscv_iommu_iofence_sync(ep->iommu);
> +       }
> +
> +       dev_info(dev, "domain type %d attached w/ PSCID %u PASID %u\n",
> +           domain->domain.type, domain->pscid, domain->pasid);
> +
> +       return 0;
> +}
> +
> +static void riscv_iommu_remove_dev_pasid(struct device *dev, ioasid_t pa=
sid)
> +{
> +       struct riscv_iommu_endpoint *ep =3D dev_iommu_priv_get(dev);
> +       struct riscv_iommu_command cmd;
> +       unsigned long payload =3D riscv_iommu_ats_inval_all_payload(false=
);
> +       u64 ta;
> +
> +       /* invalidate TA.V */
> +       ta =3D le64_to_cpu(xchg_relaxed(&(ep->pc[pasid].ta), 0));
> +
> +       wmb();
> +
> +       dev_info(dev, "domain removed w/ PSCID %u PASID %u\n",
> +           (unsigned)FIELD_GET(RISCV_IOMMU_PC_TA_PSCID, ta), pasid);
> +
> +       /* 1. invalidate PDT entry */
> +       riscv_iommu_iodir_inv_pasid(ep->iommu, ep->devid, pasid);
> +
> +       /* 2. invalidate all matching IOATC entries (if PASID was valid) =
*/
> +       if (ta & RISCV_IOMMU_PC_TA_V) {
> +               riscv_iommu_cmd_inval_vma(&cmd);
> +               riscv_iommu_cmd_inval_set_gscid(&cmd, 0);
> +               riscv_iommu_cmd_inval_set_pscid(&cmd,
> +                   FIELD_GET(RISCV_IOMMU_PC_TA_PSCID, ta));
> +               riscv_iommu_post(ep->iommu, &cmd);
> +       }
> +
> +       /* 3. Wait IOATC flush to happen */
> +       riscv_iommu_iofence_sync(ep->iommu);
> +
> +       /* 4. ATS invalidation */
> +       riscv_iommu_cmd_ats_inval(&cmd);
> +       riscv_iommu_cmd_ats_set_dseg(&cmd, ep->domid);
> +       riscv_iommu_cmd_ats_set_rid(&cmd, ep->devid);
> +       riscv_iommu_cmd_ats_set_pid(&cmd, pasid);
> +       riscv_iommu_cmd_ats_set_payload(&cmd, payload);
> +       riscv_iommu_post(ep->iommu, &cmd);
> +
> +       /* 5. Wait DevATC flush to happen */
> +       riscv_iommu_iofence_sync(ep->iommu);
> +}
> +
>  static void riscv_iommu_flush_iotlb_range(struct iommu_domain *iommu_dom=
ain,
>                                           unsigned long *start, unsigned =
long *end,
>                                           size_t *pgsize)
>  {
>         struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
>         struct riscv_iommu_command cmd;
> +       struct riscv_iommu_endpoint *endpoint;
>         unsigned long iova;
> +       unsigned long payload;
>
>         if (domain->mode =3D=3D RISCV_IOMMU_DC_FSC_MODE_BARE)
>                 return;
> @@ -1065,6 +1616,12 @@ static void riscv_iommu_flush_iotlb_range(struct i=
ommu_domain *iommu_domain,
>         /* Domain not attached to an IOMMU! */
>         BUG_ON(!domain->iommu);
>
> +       if (start && end) {
> +               payload =3D riscv_iommu_ats_inval_payload(*start, *end, t=
rue);
> +       } else {
> +               payload =3D riscv_iommu_ats_inval_all_payload(true);
> +       }
> +
>         riscv_iommu_cmd_inval_vma(&cmd);
>         riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
>
> @@ -1078,6 +1635,20 @@ static void riscv_iommu_flush_iotlb_range(struct i=
ommu_domain *iommu_domain,
>                 riscv_iommu_post(domain->iommu, &cmd);
>         }
>         riscv_iommu_iofence_sync(domain->iommu);
> +
> +       /* ATS invalidation for every device and for every translation */
> +       list_for_each_entry(endpoint, &domain->endpoints, domain) {
> +               if (!endpoint->pasid_enabled)
> +                       continue;
> +
> +               riscv_iommu_cmd_ats_inval(&cmd);
> +               riscv_iommu_cmd_ats_set_dseg(&cmd, endpoint->domid);
> +               riscv_iommu_cmd_ats_set_rid(&cmd, endpoint->devid);
> +               riscv_iommu_cmd_ats_set_pid(&cmd, domain->pasid);
> +               riscv_iommu_cmd_ats_set_payload(&cmd, payload);
> +               riscv_iommu_post(domain->iommu, &cmd);
> +       }
> +       riscv_iommu_iofence_sync(domain->iommu);
>  }
>
>  static void riscv_iommu_flush_iotlb_all(struct iommu_domain *iommu_domai=
n)
> @@ -1310,6 +1881,7 @@ static int riscv_iommu_enable(struct riscv_iommu_de=
vice *iommu, unsigned request
>  static const struct iommu_domain_ops riscv_iommu_domain_ops =3D {
>         .free =3D riscv_iommu_domain_free,
>         .attach_dev =3D riscv_iommu_attach_dev,
> +       .set_dev_pasid =3D riscv_iommu_set_dev_pasid,
>         .map_pages =3D riscv_iommu_map_pages,
>         .unmap_pages =3D riscv_iommu_unmap_pages,
>         .iova_to_phys =3D riscv_iommu_iova_to_phys,
> @@ -1326,9 +1898,13 @@ static const struct iommu_ops riscv_iommu_ops =3D =
{
>         .probe_device =3D riscv_iommu_probe_device,
>         .probe_finalize =3D riscv_iommu_probe_finalize,
>         .release_device =3D riscv_iommu_release_device,
> +       .remove_dev_pasid =3D riscv_iommu_remove_dev_pasid,
>         .device_group =3D riscv_iommu_device_group,
>         .get_resv_regions =3D riscv_iommu_get_resv_regions,
>         .of_xlate =3D riscv_iommu_of_xlate,
> +       .dev_enable_feat =3D riscv_iommu_dev_enable_feat,
> +       .dev_disable_feat =3D riscv_iommu_dev_disable_feat,
> +       .page_response =3D riscv_iommu_page_response,
>         .default_domain_ops =3D &riscv_iommu_domain_ops,
>  };
>
> @@ -1340,6 +1916,7 @@ void riscv_iommu_remove(struct riscv_iommu_device *=
iommu)
>         riscv_iommu_queue_free(iommu, &iommu->cmdq);
>         riscv_iommu_queue_free(iommu, &iommu->fltq);
>         riscv_iommu_queue_free(iommu, &iommu->priq);
> +       iopf_queue_free(iommu->pq_work);
>  }
>
>  int riscv_iommu_init(struct riscv_iommu_device *iommu)
> @@ -1362,6 +1939,12 @@ int riscv_iommu_init(struct riscv_iommu_device *io=
mmu)
>         }
>  #endif
>
> +       if (iommu->cap & RISCV_IOMMU_CAP_PD20)
> +               iommu->iommu.max_pasids =3D 1u << 20;
> +       else if (iommu->cap & RISCV_IOMMU_CAP_PD17)
> +               iommu->iommu.max_pasids =3D 1u << 17;
> +       else if (iommu->cap & RISCV_IOMMU_CAP_PD8)
> +               iommu->iommu.max_pasids =3D 1u << 8;
>         /*
>          * Assign queue lengths from module parameters if not already
>          * set on the device tree.
> @@ -1387,6 +1970,13 @@ int riscv_iommu_init(struct riscv_iommu_device *io=
mmu)
>                 goto fail;
>         if (!(iommu->cap & RISCV_IOMMU_CAP_ATS))
>                 goto no_ats;
> +       /* PRI functionally depends on ATS=E2=80=99s capabilities. */
> +       iommu->pq_work =3D iopf_queue_alloc(dev_name(dev));
> +       if (!iommu->pq_work) {
> +               dev_err(dev, "failed to allocate iopf queue\n");
> +               ret =3D -ENOMEM;
> +               goto fail;
> +       }
>
>         ret =3D riscv_iommu_queue_init(iommu, RISCV_IOMMU_PAGE_REQUEST_QU=
EUE);
>         if (ret)
> @@ -1424,5 +2014,6 @@ int riscv_iommu_init(struct riscv_iommu_device *iom=
mu)
>         riscv_iommu_queue_free(iommu, &iommu->priq);
>         riscv_iommu_queue_free(iommu, &iommu->fltq);
>         riscv_iommu_queue_free(iommu, &iommu->cmdq);
> +       iopf_queue_free(iommu->pq_work);
>         return ret;
>  }
> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> index fe32a4eff14e..83e8d00fd0f8 100644
> --- a/drivers/iommu/riscv/iommu.h
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -17,9 +17,11 @@
>  #include <linux/iova.h>
>  #include <linux/io.h>
>  #include <linux/idr.h>
> +#include <linux/mmu_notifier.h>
>  #include <linux/list.h>
>  #include <linux/iommu.h>
>  #include <linux/io-pgtable.h>
> +#include <linux/mmu_notifier.h>

You include the mmu_notifier.h twice in this header

>
>  #include "iommu-bits.h"
>
> @@ -76,6 +78,9 @@ struct riscv_iommu_device {
>         unsigned ddt_mode;
>         bool ddtp_in_iomem;
>
> +       /* I/O page fault queue */
> +       struct iopf_queue *pq_work;
> +
>         /* hardware queues */
>         struct riscv_iommu_queue cmdq;
>         struct riscv_iommu_queue fltq;
> @@ -91,11 +96,14 @@ struct riscv_iommu_domain {
>         struct io_pgtable pgtbl;
>
>         struct list_head endpoints;
> +       struct list_head notifiers;
>         struct mutex lock;
> +       struct mmu_notifier mn;
>         struct riscv_iommu_device *iommu;
>
>         unsigned mode;          /* RIO_ATP_MODE_* enum */
>         unsigned pscid;         /* RISC-V IOMMU PSCID */
> +       ioasid_t pasid;         /* IOMMU_DOMAIN_SVA: Cached PASID */
>
>         pgd_t *pgd_root;        /* page table root pointer */
>  };
> @@ -107,10 +115,16 @@ struct riscv_iommu_endpoint {
>         unsigned domid;                         /* PCI domain number, seg=
ment */
>         struct rb_node node;                    /* device tracking node (=
lookup by devid) */
>         struct riscv_iommu_dc *dc;              /* device context pointer=
 */
> +       struct riscv_iommu_pc *pc;              /* process context root, =
valid if pasid_enabled is true */
>         struct riscv_iommu_device *iommu;       /* parent iommu device */
>
>         struct mutex lock;
>         struct list_head domain;                /* endpoint attached mana=
ged domain */
> +
> +       /* end point info bits */
> +       unsigned pasid_bits;
> +       unsigned pasid_feat;
> +       bool pasid_enabled;
>  };
>
>  /* Helper functions and macros */
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
