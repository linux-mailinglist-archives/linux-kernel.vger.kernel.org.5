Return-Path: <linux-kernel+bounces-19669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C5282709B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9FD1C21FA9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04FA46535;
	Mon,  8 Jan 2024 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Gz1e+U40"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC8746526
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cca8eb0509so18687301fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 06:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704722648; x=1705327448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n+hPfWFQyTXUa/Uzxq/GNjYCij/OksAZ5ajvGrrboGc=;
        b=Gz1e+U40yu8kiqKQyW0hbpyEodWnuLTQG2yHImx57F/wQwklk1G2i+pVBIjCH+PrqW
         +4bhkD6t7gzBxyDf4I0frrqwH2Syd583milPJK0NG92S6vsJkYHPQjkFNjRm+y84sesj
         BWFjPn4HU9HthJvO8dmP478Al6KRFeN8EamuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704722648; x=1705327448;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+hPfWFQyTXUa/Uzxq/GNjYCij/OksAZ5ajvGrrboGc=;
        b=gROyYlN+x79/L8dCiOV03URaP7qiSKFIrP/pWjDuY6jdDEY6d/c/uwjXyShc5sEIli
         Co5FfLlDZ07rzcf9taSFLMu5CwaOpEKU6fQMXIVBv6HupLrBXFw2ulxlqfoHZ3Vv/BEx
         da8rAlb3vsY7OII2c/2GIAomLstb97IiVeHh5Yz/7vzZBW2/36g5wTw1StgHOB/EQ0lo
         KEeROrGto6iyA4HomdfTcCX3U+4kRYKsxwJA56yojt900xBXNE0z+hRCu72z3d4/sjWm
         wtVAwPYAQJKUo49HLbgcYq6awKu0SZbi78YQMPAtaXFLyRHLNqty4y6N04NGl/JkfRJZ
         7Seg==
X-Gm-Message-State: AOJu0Yy7vHknr4g3fSNN7owgf5mLZ5IDmxj7CFk2b60Ujv9Ss90y2qP3
	68OqcJnzT/AJ0k6EpovcB/jVhxrENtuxcxSAdkfcQUJsJKxG
X-Google-Smtp-Source: AGHT+IEWrPypVfZpYhA+BHQq4OdGGtdNVpQgxZ14ouiYBarFZVB3E26bOGDNEJ95PFgpxgORU3QJ6M/z5i8c7Rgu8uI=
X-Received: by 2002:a2e:a78e:0:b0:2cc:eeea:9e89 with SMTP id
 c14-20020a2ea78e000000b002cceeea9e89mr1877042ljf.7.1704722648027; Mon, 08 Jan
 2024 06:04:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108124213.2966536-1-srasheed@marvell.com> <20240108124213.2966536-3-srasheed@marvell.com>
In-Reply-To: <20240108124213.2966536-3-srasheed@marvell.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 8 Jan 2024 19:33:55 +0530
Message-ID: <CAH-L+nMFiqcqe=0vHmGdG2FNyQ4-koK3WSqqABUHPk8uFKUvoQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/8] octeon_ep_vf: add hardware configuration APIs
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com, 
	vimleshk@marvell.com, sedara@marvell.com, egallen@redhat.com, 
	mschmidt@redhat.com, pabeni@redhat.com, kuba@kernel.org, horms@kernel.org, 
	wizhao@redhat.com, kheib@redhat.com, konguyen@redhat.com, 
	Veerasenareddy Burru <vburru@marvell.com>, Satananda Burla <sburla@marvell.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e9e023060e6fab2e"

--000000000000e9e023060e6fab2e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 6:17=E2=80=AFPM Shinas Rasheed <srasheed@marvell.com=
> wrote:
>
> Implement hardware resource init and shutdown helper APIs, like
> hardware Tx/Rx queue init/enable/disable/reset.
>
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
> V4:
>   - No changes
>
> V3: https://lore.kernel.org/all/20240105203823.2953604-3-srasheed@marvell=
.com/
>   - Replaced masks and ULL declarations with GENMASK_ULL(), ULL() and
>     other linux/bits.h macros
>   - Corrected declarations to conform to xmas tree format
>
> V2: https://lore.kernel.org/all/20231223134000.2906144-3-srasheed@marvell=
.com/
>   - No changes
>
> V1: https://lore.kernel.org/all/20231221092844.2885872-3-srasheed@marvell=
.com/
>
>  .../marvell/octeon_ep_vf/octep_vf_cn9k.c      | 336 ++++++++++++++++-
>  .../marvell/octeon_ep_vf/octep_vf_cnxk.c      | 346 +++++++++++++++++-
>  2 files changed, 680 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c b/=
drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
> index c24ef2265205..bb8c58dd4d7c 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
> @@ -13,9 +13,125 @@
>  #include "octep_vf_main.h"
>  #include "octep_vf_regs_cn9k.h"
>
> +/* Dump useful hardware IQ/OQ CSRs for debug purpose */
> +static void cn93_vf_dump_q_regs(struct octep_vf_device *oct, int qno)
> +{
> +       struct device *dev =3D &oct->pdev->dev;
> +
> +       dev_info(dev, "IQ-%d register dump\n", qno);
> +       dev_info(dev, "R[%d]_IN_INSTR_DBELL[0x%llx]: 0x%016llx\n",
> +                qno, CN93_VF_SDP_R_IN_INSTR_DBELL(qno),
> +                octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_INSTR_DBELL(qn=
o)));
> +       dev_info(dev, "R[%d]_IN_CONTROL[0x%llx]: 0x%016llx\n",
> +                qno, CN93_VF_SDP_R_IN_CONTROL(qno),
> +                octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_CONTROL(qno)))=
;
> +       dev_info(dev, "R[%d]_IN_ENABLE[0x%llx]: 0x%016llx\n",
> +                qno, CN93_VF_SDP_R_IN_ENABLE(qno),
> +                octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_ENABLE(qno)));
> +       dev_info(dev, "R[%d]_IN_INSTR_BADDR[0x%llx]: 0x%016llx\n",
> +                qno, CN93_VF_SDP_R_IN_INSTR_BADDR(qno),
> +                octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_INSTR_BADDR(qn=
o)));
> +       dev_info(dev, "R[%d]_IN_INSTR_RSIZE[0x%llx]: 0x%016llx\n",
> +                qno, CN93_VF_SDP_R_IN_INSTR_RSIZE(qno),
> +                octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_INSTR_RSIZE(qn=
o)));
> +       dev_info(dev, "R[%d]_IN_CNTS[0x%llx]: 0x%016llx\n",
> +                qno, CN93_VF_SDP_R_IN_CNTS(qno),
> +                octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_CNTS(qno)));
> +       dev_info(dev, "R[%d]_IN_INT_LEVELS[0x%llx]: 0x%016llx\n",
> +                qno, CN93_VF_SDP_R_IN_INT_LEVELS(qno),
> +                octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_INT_LEVELS(qno=
)));
> +       dev_info(dev, "R[%d]_IN_PKT_CNT[0x%llx]: 0x%016llx\n",
> +                qno, CN93_VF_SDP_R_IN_PKT_CNT(qno),
> +                octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_PKT_CNT(qno)))=
;
> +       dev_info(dev, "R[%d]_IN_BYTE_CNT[0x%llx]: 0x%016llx\n",
> +                qno, CN93_VF_SDP_R_IN_BYTE_CNT(qno),
> +                octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_BYTE_CNT(qno))=
);
> +
> +       dev_info(dev, "OQ-%d register dump\n", qno);
> +       dev_info(dev, "R[%d]_OUT_SLIST_DBELL[0x%llx]: 0x%016llx\n",
> +                qno, CN93_VF_SDP_R_OUT_SLIST_DBELL(qno),
> +                octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_SLIST_DBELL(q=
no)));
> +       dev_info(dev, "R[%d]_OUT_CONTROL[0x%llx]: 0x%016llx\n",
> +                qno, CN93_VF_SDP_R_OUT_CONTROL(qno),
> +                octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_CONTROL(qno))=
);
> +       dev_info(dev, "R[%d]_OUT_ENABLE[0x%llx]: 0x%016llx\n",
> +                qno, CN93_VF_SDP_R_OUT_ENABLE(qno),
> +                octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_ENABLE(qno)))=
;
> +       dev_info(dev, "R[%d]_OUT_SLIST_BADDR[0x%llx]: 0x%016llx\n",
> +                qno, CN93_VF_SDP_R_OUT_SLIST_BADDR(qno),
> +                octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_SLIST_BADDR(q=
no)));
> +       dev_info(dev, "R[%d]_OUT_SLIST_RSIZE[0x%llx]: 0x%016llx\n",
> +                qno, CN93_VF_SDP_R_OUT_SLIST_RSIZE(qno),
> +                octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_SLIST_RSIZE(q=
no)));
> +       dev_info(dev, "R[%d]_OUT_CNTS[0x%llx]: 0x%016llx\n",
> +                qno, CN93_VF_SDP_R_OUT_CNTS(qno),
> +                octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_CNTS(qno)));
> +       dev_info(dev, "R[%d]_OUT_INT_LEVELS[0x%llx]: 0x%016llx\n",
> +                qno, CN93_VF_SDP_R_OUT_INT_LEVELS(qno),
> +                octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_INT_LEVELS(qn=
o)));
> +       dev_info(dev, "R[%d]_OUT_PKT_CNT[0x%llx]: 0x%016llx\n",
> +                qno, CN93_VF_SDP_R_OUT_PKT_CNT(qno),
> +                octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_PKT_CNT(qno))=
);
> +       dev_info(dev, "R[%d]_OUT_BYTE_CNT[0x%llx]: 0x%016llx\n",
> +                qno, CN93_VF_SDP_R_OUT_BYTE_CNT(qno),
> +                octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_BYTE_CNT(qno)=
));
> +}
> +
> +/* Reset Hardware Tx queue */
> +static int cn93_vf_reset_iq(struct octep_vf_device *oct, int q_no)
[Kalesh] You can change it to a void function as it return 0 always
and the caller is not checking return status.
> +{
> +       u64 val =3D ULL(0);
> +
> +       dev_dbg(&oct->pdev->dev, "Reset VF IQ-%d\n", q_no);
> +
> +       /* Disable the Tx/Instruction Ring */
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_ENABLE(q_no), val);
> +
> +       /* clear the Instruction Ring packet/byte counts and doorbell CSR=
s */
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INT_LEVELS(q_no), val)=
;
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_PKT_CNT(q_no), val);
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_BYTE_CNT(q_no), val);
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INSTR_BADDR(q_no), val=
);
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INSTR_RSIZE(q_no), val=
);
> +
> +       val =3D GENMASK_ULL(31, 0);
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INSTR_DBELL(q_no), val=
);
> +
> +       val =3D octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_CNTS(q_no));
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_CNTS(q_no),
> +                            val & GENMASK_ULL(31, 0));
> +
> +       return 0;
> +}
> +
> +/* Reset Hardware Rx queue */
> +static void cn93_vf_reset_oq(struct octep_vf_device *oct, int q_no)
> +{
> +       u64 val =3D ULL(0);
> +
> +       /* Disable Output (Rx) Ring */
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_ENABLE(q_no), val);
> +
> +       /* Clear count CSRs */
> +       val =3D octep_vf_read_csr(oct, CN93_VF_SDP_R_OUT_CNTS(q_no));
> +       octep_vf_write_csr(oct, CN93_VF_SDP_R_OUT_CNTS(q_no), val);
> +
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_PKT_CNT(q_no), GENMAS=
K_ULL(35, 0));
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_SLIST_DBELL(q_no), GE=
NMASK_ULL(31, 0));
> +}
> +
>  /* Reset all hardware Tx/Rx queues */
>  static void octep_vf_reset_io_queues_cn93(struct octep_vf_device *oct)
>  {
> +       struct pci_dev *pdev =3D oct->pdev;
> +       int q;
> +
> +       dev_dbg(&pdev->dev, "Reset OCTEP_CN93 VF IO Queues\n");
> +
> +       for (q =3D 0; q < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); q++) =
{
> +               cn93_vf_reset_iq(oct, q);
> +               cn93_vf_reset_oq(oct, q);
> +       }
>  }
>
>  /* Initialize configuration limits and initial active config */
> @@ -46,78 +162,296 @@ static void octep_vf_init_config_cn93_vf(struct oct=
ep_vf_device *oct)
>  /* Setup registers for a hardware Tx Queue  */
>  static void octep_vf_setup_iq_regs_cn93(struct octep_vf_device *oct, int=
 iq_no)
>  {
> +       struct octep_vf_iq *iq =3D oct->iq[iq_no];
> +       u32 reset_instr_cnt;
> +       u64 reg_val;
> +
> +       reg_val =3D octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_CONTROL(iq_=
no));
> +
> +       /* wait for IDLE to set to 1 */
> +       if (!(reg_val & CN93_VF_R_IN_CTL_IDLE)) {
> +               do {
> +                       reg_val =3D octep_vf_read_csr64(oct, CN93_VF_SDP_=
R_IN_CONTROL(iq_no));
> +               } while (!(reg_val & CN93_VF_R_IN_CTL_IDLE));
> +       }
> +       reg_val |=3D CN93_VF_R_IN_CTL_RDSIZE;
> +       reg_val |=3D CN93_VF_R_IN_CTL_IS_64B;
> +       reg_val |=3D CN93_VF_R_IN_CTL_ESR;
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_CONTROL(iq_no), reg_va=
l);
> +
> +       /* Write the start of the input queue's ring and its size  */
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INSTR_BADDR(iq_no), iq=
->desc_ring_dma);
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INSTR_RSIZE(iq_no), iq=
->max_count);
> +
> +       /* Remember the doorbell & instruction count register addr for th=
is queue */
> +       iq->doorbell_reg =3D oct->mmio.hw_addr + CN93_VF_SDP_R_IN_INSTR_D=
BELL(iq_no);
> +       iq->inst_cnt_reg =3D oct->mmio.hw_addr + CN93_VF_SDP_R_IN_CNTS(iq=
_no);
> +       iq->intr_lvl_reg =3D oct->mmio.hw_addr + CN93_VF_SDP_R_IN_INT_LEV=
ELS(iq_no);
> +
> +       /* Store the current instruction counter (used in flush_iq calcul=
ation) */
> +       reset_instr_cnt =3D readl(iq->inst_cnt_reg);
> +       writel(reset_instr_cnt, iq->inst_cnt_reg);
> +
> +       /* INTR_THRESHOLD is set to max(FFFFFFFF) to disable the INTR */
> +       reg_val =3D CFG_GET_IQ_INTR_THRESHOLD(oct->conf) & GENMASK_ULL(31=
, 0);
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INT_LEVELS(iq_no), reg=
_val);
>  }
>
>  /* Setup registers for a hardware Rx Queue  */
>  static void octep_vf_setup_oq_regs_cn93(struct octep_vf_device *oct, int=
 oq_no)
>  {
> +       struct octep_vf_oq *oq =3D oct->oq[oq_no];
> +       u32 time_threshold =3D 0;
> +       u64 oq_ctl =3D ULL(0);
> +       u64 reg_val;
> +
> +       reg_val =3D octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_CONTROL(oq=
_no));
> +
> +       /* wait for IDLE to set to 1 */
> +       if (!(reg_val & CN93_VF_R_OUT_CTL_IDLE)) {
> +               do {
> +                       reg_val =3D octep_vf_read_csr64(oct, CN93_VF_SDP_=
R_OUT_CONTROL(oq_no));
> +               } while (!(reg_val & CN93_VF_R_OUT_CTL_IDLE));
> +       }
> +
> +       reg_val &=3D ~(CN93_VF_R_OUT_CTL_IMODE);
> +       reg_val &=3D ~(CN93_VF_R_OUT_CTL_ROR_P);
> +       reg_val &=3D ~(CN93_VF_R_OUT_CTL_NSR_P);
> +       reg_val &=3D ~(CN93_VF_R_OUT_CTL_ROR_I);
> +       reg_val &=3D ~(CN93_VF_R_OUT_CTL_NSR_I);
> +       reg_val &=3D ~(CN93_VF_R_OUT_CTL_ES_I);
> +       reg_val &=3D ~(CN93_VF_R_OUT_CTL_ROR_D);
> +       reg_val &=3D ~(CN93_VF_R_OUT_CTL_NSR_D);
> +       reg_val &=3D ~(CN93_VF_R_OUT_CTL_ES_D);
> +       reg_val |=3D (CN93_VF_R_OUT_CTL_ES_P);
> +
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_CONTROL(oq_no), reg_v=
al);
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_SLIST_BADDR(oq_no), o=
q->desc_ring_dma);
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_SLIST_RSIZE(oq_no), o=
q->max_count);
> +
> +       oq_ctl =3D octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_CONTROL(oq_=
no));
> +       oq_ctl &=3D ~GENMASK_ULL(22, 0);  //clear the ISIZE and BSIZE (22=
-0)
> +       oq_ctl |=3D (oq->buffer_size & GENMASK_ULL(15, 0));       //popul=
ate the BSIZE (15-0)
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_CONTROL(oq_no), oq_ct=
l);
> +
> +       /* Get the mapped address of the pkt_sent and pkts_credit regs */
> +       oq->pkts_sent_reg =3D oct->mmio.hw_addr + CN93_VF_SDP_R_OUT_CNTS(=
oq_no);
> +       oq->pkts_credit_reg =3D oct->mmio.hw_addr + CN93_VF_SDP_R_OUT_SLI=
ST_DBELL(oq_no);
> +
> +       time_threshold =3D CFG_GET_OQ_INTR_TIME(oct->conf);
> +       reg_val =3D ((u64)time_threshold << 32) | CFG_GET_OQ_INTR_PKT(oct=
->conf);
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_INT_LEVELS(oq_no), re=
g_val);
>  }
>
>  /* Setup registers for a VF mailbox */
>  static void octep_vf_setup_mbox_regs_cn93(struct octep_vf_device *oct, i=
nt q_no)
>  {
> +       struct octep_vf_mbox *mbox =3D oct->mbox;
> +
> +       /* PF to VF DATA reg. VF reads from this reg */
> +       mbox->mbox_read_reg =3D oct->mmio.hw_addr + CN93_VF_SDP_R_MBOX_PF=
_VF_DATA(q_no);
> +
> +       /* VF mbox interrupt reg */
> +       mbox->mbox_int_reg =3D oct->mmio.hw_addr + CN93_VF_SDP_R_MBOX_PF_=
VF_INT(q_no);
> +
> +       /* VF to PF DATA reg. VF writes into this reg */
> +       mbox->mbox_write_reg =3D oct->mmio.hw_addr + CN93_VF_SDP_R_MBOX_V=
F_PF_DATA(q_no);
> +}
> +
> +/* Mailbox Interrupt handler */
> +static void cn93_handle_vf_mbox_intr(struct octep_vf_device *oct)
> +{
> +       if (oct->mbox)
> +               schedule_work(&oct->mbox->wk.work);
> +       else
> +               dev_err(&oct->pdev->dev, "cannot schedule work on invalid=
 mbox\n");
>  }
>
>  /* Tx/Rx queue interrupt handler */
>  static irqreturn_t octep_vf_ioq_intr_handler_cn93(void *data)
>  {
> +       struct octep_vf_ioq_vector *vector =3D data;
> +       struct octep_vf_device *oct;
> +       struct octep_vf_oq *oq;
> +       u64 reg_val =3D ULL(0);
[Kalesh] Do you really want to initialize reg_val here?
> +
> +       oct =3D vector->octep_vf_dev;
> +       oq =3D vector->oq;
> +       /* Mailbox interrupt arrives along with interrupt of tx/rx ring p=
air 0 */
> +       if (oq->q_no =3D=3D 0) {
> +               reg_val =3D octep_vf_read_csr64(oct, CN93_VF_SDP_R_MBOX_P=
F_VF_INT(0));
> +               if (reg_val & CN93_VF_SDP_R_MBOX_PF_VF_INT_STATUS) {
> +                       cn93_handle_vf_mbox_intr(oct);
> +                       octep_vf_write_csr64(oct, CN93_VF_SDP_R_MBOX_PF_V=
F_INT(0), reg_val);
> +               }
> +       }
> +       napi_schedule_irqoff(oq->napi);
>         return IRQ_HANDLED;
>  }
>
>  /* Re-initialize Octeon hardware registers */
>  static void octep_vf_reinit_regs_cn93(struct octep_vf_device *oct)
>  {
> +       u32 i;
> +
> +       for (i =3D 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++)
> +               oct->hw_ops.setup_iq_regs(oct, i);
> +
> +       for (i =3D 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++)
> +               oct->hw_ops.setup_oq_regs(oct, i);
> +
> +       oct->hw_ops.enable_interrupts(oct);
> +       oct->hw_ops.enable_io_queues(oct);
> +
> +       for (i =3D 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++)
> +               writel(oct->oq[i]->max_count, oct->oq[i]->pkts_credit_reg=
);
>  }
>
>  /* Enable all interrupts */
>  static void octep_vf_enable_interrupts_cn93(struct octep_vf_device *oct)
>  {
> +       int num_rings, q;
> +       u64 reg_val;
> +
> +       num_rings =3D CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
> +       for (q =3D 0; q < num_rings; q++) {
> +               reg_val =3D octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_INT=
_LEVELS(q));
> +               reg_val |=3D BIT_ULL_MASK(62);
> +               octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INT_LEVELS(q),=
 reg_val);
> +
> +               reg_val =3D octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_IN=
T_LEVELS(q));
> +               reg_val |=3D BIT_ULL_MASK(62);
> +               octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_INT_LEVELS(q)=
, reg_val);
> +       }
> +       /* Enable PF to VF mbox interrupt by setting 2nd bit*/
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_MBOX_PF_VF_INT(0),
> +                            CN93_VF_SDP_R_MBOX_PF_VF_INT_ENAB);
>  }
>
>  /* Disable all interrupts */
>  static void octep_vf_disable_interrupts_cn93(struct octep_vf_device *oct=
)
>  {
> +       int num_rings, q;
> +       u64 reg_val;
> +
> +       /* Disable PF to VF mbox interrupt by setting 2nd bit*/
> +       if (oct->mbox)
> +               octep_vf_write_csr64(oct, CN93_VF_SDP_R_MBOX_PF_VF_INT(0)=
, 0x0);
> +
> +       num_rings =3D CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
> +       for (q =3D 0; q < num_rings; q++) {
> +               reg_val =3D octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_INT=
_LEVELS(q));
> +               reg_val &=3D ~BIT_ULL_MASK(62);
> +               octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INT_LEVELS(q),=
 reg_val);
> +
> +               reg_val =3D octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_IN=
T_LEVELS(q));
> +               reg_val &=3D ~BIT_ULL_MASK(62);
> +               octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_INT_LEVELS(q)=
, reg_val);
> +       }
>  }
>
>  /* Get new Octeon Read Index: index of descriptor that Octeon reads next=
. */
>  static u32 octep_vf_update_iq_read_index_cn93(struct octep_vf_iq *iq)
>  {
> -       return 0;
> +       u32 pkt_in_done =3D readl(iq->inst_cnt_reg);
> +       u32 last_done, new_idx;
> +
> +       last_done =3D pkt_in_done - iq->pkt_in_done;
> +       iq->pkt_in_done =3D pkt_in_done;
> +
> +       new_idx =3D (iq->octep_vf_read_index + last_done) % iq->max_count=
;
> +
> +       return new_idx;
>  }
>
>  /* Enable a hardware Tx Queue */
>  static void octep_vf_enable_iq_cn93(struct octep_vf_device *oct, int iq_=
no)
>  {
> +       u64 loop =3D HZ;
> +       u64 reg_val;
> +
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INSTR_DBELL(iq_no), GE=
NMASK_ULL(31, 0));
> +
> +       while (octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_INSTR_DBELL(iq_n=
o)) &&
> +              loop--) {
> +               schedule_timeout_interruptible(1);
> +       }
> +
> +       reg_val =3D octep_vf_read_csr64(oct,  CN93_VF_SDP_R_IN_INT_LEVELS=
(iq_no));
> +       reg_val |=3D BIT_ULL_MASK(62);
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INT_LEVELS(iq_no), reg=
_val);
> +
> +       reg_val =3D octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_ENABLE(iq_n=
o));
> +       reg_val |=3D ULL(1);
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_ENABLE(iq_no), reg_val=
);
>  }
>
>  /* Enable a hardware Rx Queue */
>  static void octep_vf_enable_oq_cn93(struct octep_vf_device *oct, int oq_=
no)
>  {
> +       u64 reg_val =3D ULL(0);
[Kalesh] Same comment as above
> +
> +       reg_val =3D octep_vf_read_csr64(oct,  CN93_VF_SDP_R_OUT_INT_LEVEL=
S(oq_no));
> +       reg_val |=3D BIT_ULL_MASK(62);
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_INT_LEVELS(oq_no), re=
g_val);
> +
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_SLIST_DBELL(oq_no), G=
ENMASK_ULL(31, 0));
> +
> +       reg_val =3D octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_ENABLE(oq_=
no));
> +       reg_val |=3D ULL(1);
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_ENABLE(oq_no), reg_va=
l);
>  }
>
>  /* Enable all hardware Tx/Rx Queues assigned to VF */
>  static void octep_vf_enable_io_queues_cn93(struct octep_vf_device *oct)
>  {
> +       u8 q;
> +
> +       for (q =3D 0; q < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); q++) =
{
> +               octep_vf_enable_iq_cn93(oct, q);
> +               octep_vf_enable_oq_cn93(oct, q);
> +       }
>  }
>
>  /* Disable a hardware Tx Queue assigned to VF */
>  static void octep_vf_disable_iq_cn93(struct octep_vf_device *oct, int iq=
_no)
>  {
> +       u64 reg_val =3D ULL(0);
[Kalesh] Same comment as above and function below
> +
> +       reg_val =3D octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_ENABLE(iq_n=
o));
> +       reg_val &=3D ~ULL(1);
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_ENABLE(iq_no), reg_val=
);
>  }
>
>  /* Disable a hardware Rx Queue assigned to VF */
>  static void octep_vf_disable_oq_cn93(struct octep_vf_device *oct, int oq=
_no)
>  {
> +       u64 reg_val =3D ULL(0);
> +
> +       reg_val =3D octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_ENABLE(oq_=
no));
> +       reg_val &=3D ~ULL(1);
> +       octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_ENABLE(oq_no), reg_va=
l);
>  }
>
>  /* Disable all hardware Tx/Rx Queues assigned to VF */
>  static void octep_vf_disable_io_queues_cn93(struct octep_vf_device *oct)
>  {
> +       int q =3D 0;
> +
> +       for (q =3D 0; q < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); q++) =
{
> +               octep_vf_disable_iq_cn93(oct, q);
> +               octep_vf_disable_oq_cn93(oct, q);
> +       }
>  }
>
>  /* Dump hardware registers (including Tx/Rx queues) for debugging. */
>  static void octep_vf_dump_registers_cn93(struct octep_vf_device *oct)
>  {
> +       u8 num_rings, q;
> +
> +       num_rings =3D CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
> +       for (q =3D 0; q < num_rings; q++)
> +               cn93_vf_dump_q_regs(oct, q);
>  }
>
>  /**
> diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c b/=
drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c
> index af07a4a6edc5..3440d4345985 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c
> @@ -13,9 +13,127 @@
>  #include "octep_vf_main.h"
>  #include "octep_vf_regs_cnxk.h"
>
> +/* Dump useful hardware IQ/OQ CSRs for debug purpose */
> +static void cnxk_vf_dump_q_regs(struct octep_vf_device *oct, int qno)
> +{
> +       struct device *dev =3D &oct->pdev->dev;
> +
> +       dev_info(dev, "IQ-%d register dump\n", qno);
> +       dev_info(dev, "R[%d]_IN_INSTR_DBELL[0x%llx]: 0x%016llx\n",
> +                qno, CNXK_VF_SDP_R_IN_INSTR_DBELL(qno),
> +                octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_INSTR_DBELL(qn=
o)));
> +       dev_info(dev, "R[%d]_IN_CONTROL[0x%llx]: 0x%016llx\n",
> +                qno, CNXK_VF_SDP_R_IN_CONTROL(qno),
> +                octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_CONTROL(qno)))=
;
> +       dev_info(dev, "R[%d]_IN_ENABLE[0x%llx]: 0x%016llx\n",
> +                qno, CNXK_VF_SDP_R_IN_ENABLE(qno),
> +                octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_ENABLE(qno)));
> +       dev_info(dev, "R[%d]_IN_INSTR_BADDR[0x%llx]: 0x%016llx\n",
> +                qno, CNXK_VF_SDP_R_IN_INSTR_BADDR(qno),
> +                octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_INSTR_BADDR(qn=
o)));
> +       dev_info(dev, "R[%d]_IN_INSTR_RSIZE[0x%llx]: 0x%016llx\n",
> +                qno, CNXK_VF_SDP_R_IN_INSTR_RSIZE(qno),
> +                octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_INSTR_RSIZE(qn=
o)));
> +       dev_info(dev, "R[%d]_IN_CNTS[0x%llx]: 0x%016llx\n",
> +                qno, CNXK_VF_SDP_R_IN_CNTS(qno),
> +                octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_CNTS(qno)));
> +       dev_info(dev, "R[%d]_IN_INT_LEVELS[0x%llx]: 0x%016llx\n",
> +                qno, CNXK_VF_SDP_R_IN_INT_LEVELS(qno),
> +                octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_INT_LEVELS(qno=
)));
> +       dev_info(dev, "R[%d]_IN_PKT_CNT[0x%llx]: 0x%016llx\n",
> +                qno, CNXK_VF_SDP_R_IN_PKT_CNT(qno),
> +                octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_PKT_CNT(qno)))=
;
> +       dev_info(dev, "R[%d]_IN_BYTE_CNT[0x%llx]: 0x%016llx\n",
> +                qno, CNXK_VF_SDP_R_IN_BYTE_CNT(qno),
> +                octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_BYTE_CNT(qno))=
);
> +
> +       dev_info(dev, "OQ-%d register dump\n", qno);
> +       dev_info(dev, "R[%d]_OUT_SLIST_DBELL[0x%llx]: 0x%016llx\n",
> +                qno, CNXK_VF_SDP_R_OUT_SLIST_DBELL(qno),
> +                octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_DBELL(q=
no)));
> +       dev_info(dev, "R[%d]_OUT_CONTROL[0x%llx]: 0x%016llx\n",
> +                qno, CNXK_VF_SDP_R_OUT_CONTROL(qno),
> +                octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_CONTROL(qno))=
);
> +       dev_info(dev, "R[%d]_OUT_ENABLE[0x%llx]: 0x%016llx\n",
> +                qno, CNXK_VF_SDP_R_OUT_ENABLE(qno),
> +                octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_ENABLE(qno)))=
;
> +       dev_info(dev, "R[%d]_OUT_SLIST_BADDR[0x%llx]: 0x%016llx\n",
> +                qno, CNXK_VF_SDP_R_OUT_SLIST_BADDR(qno),
> +                octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_BADDR(q=
no)));
> +       dev_info(dev, "R[%d]_OUT_SLIST_RSIZE[0x%llx]: 0x%016llx\n",
> +                qno, CNXK_VF_SDP_R_OUT_SLIST_RSIZE(qno),
> +                octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_RSIZE(q=
no)));
> +       dev_info(dev, "R[%d]_OUT_CNTS[0x%llx]: 0x%016llx\n",
> +                qno, CNXK_VF_SDP_R_OUT_CNTS(qno),
> +                octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_CNTS(qno)));
> +       dev_info(dev, "R[%d]_OUT_INT_LEVELS[0x%llx]: 0x%016llx\n",
> +                qno, CNXK_VF_SDP_R_OUT_INT_LEVELS(qno),
> +                octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_INT_LEVELS(qn=
o)));
> +       dev_info(dev, "R[%d]_OUT_PKT_CNT[0x%llx]: 0x%016llx\n",
> +                qno, CNXK_VF_SDP_R_OUT_PKT_CNT(qno),
> +                octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_PKT_CNT(qno))=
);
> +       dev_info(dev, "R[%d]_OUT_BYTE_CNT[0x%llx]: 0x%016llx\n",
> +                qno, CNXK_VF_SDP_R_OUT_BYTE_CNT(qno),
> +                octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_BYTE_CNT(qno)=
));
> +       dev_info(dev, "R[%d]_ERR_TYPE[0x%llx]: 0x%016llx\n",
> +                qno, CNXK_VF_SDP_R_ERR_TYPE(qno),
> +                octep_vf_read_csr64(oct, CNXK_VF_SDP_R_ERR_TYPE(qno)));
> +}
> +
> +/* Reset Hardware Tx queue */
> +static int cnxk_vf_reset_iq(struct octep_vf_device *oct, int q_no)
[Kalesh] You can change it to a void function as it return 0 always
and the caller is not checking return status.
> +{
> +       u64 val =3D ULL(0);
> +
> +       dev_dbg(&oct->pdev->dev, "Reset VF IQ-%d\n", q_no);
> +
> +       /* Disable the Tx/Instruction Ring */
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_ENABLE(q_no), val);
> +
> +       /* clear the Instruction Ring packet/byte counts and doorbell CSR=
s */
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_INT_LEVELS(q_no), val)=
;
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_PKT_CNT(q_no), val);
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_BYTE_CNT(q_no), val);
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_INSTR_BADDR(q_no), val=
);
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_INSTR_RSIZE(q_no), val=
);
> +
> +       val =3D GENMASK_ULL(31, 0);
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_INSTR_DBELL(q_no), val=
);
> +
> +       val =3D octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_CNTS(q_no));
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_CNTS(q_no), val & GENM=
ASK_ULL(31, 0));
> +
> +       return 0;
> +}
> +
> +/* Reset Hardware Rx queue */
> +static void cnxk_vf_reset_oq(struct octep_vf_device *oct, int q_no)
> +{
> +       u64 val =3D ULL(0);
> +
> +       /* Disable Output (Rx) Ring */
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_ENABLE(q_no), val);
> +
> +       /* Clear count CSRs */
> +       val =3D octep_vf_read_csr(oct, CNXK_VF_SDP_R_OUT_CNTS(q_no));
> +       octep_vf_write_csr(oct, CNXK_VF_SDP_R_OUT_CNTS(q_no), val);
> +
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_PKT_CNT(q_no), GENMAS=
K_ULL(35, 0));
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_DBELL(q_no), GE=
NMASK_ULL(31, 0));
> +}
> +
>  /* Reset all hardware Tx/Rx queues */
>  static void octep_vf_reset_io_queues_cnxk(struct octep_vf_device *oct)
>  {
> +       struct pci_dev *pdev =3D oct->pdev;
> +       int q;
> +
> +       dev_dbg(&pdev->dev, "Reset OCTEP_CNXK VF IO Queues\n");
> +
> +       for (q =3D 0; q < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); q++) =
{
> +               cnxk_vf_reset_iq(oct, q);
> +               cnxk_vf_reset_oq(oct, q);
> +       }
>  }
>
>  /* Initialize configuration limits and initial active config */
> @@ -47,78 +165,304 @@ static void octep_vf_init_config_cnxk_vf(struct oct=
ep_vf_device *oct)
>  /* Setup registers for a hardware Tx Queue  */
>  static void octep_vf_setup_iq_regs_cnxk(struct octep_vf_device *oct, int=
 iq_no)
>  {
> +       struct octep_vf_iq *iq =3D oct->iq[iq_no];
> +       u32 reset_instr_cnt;
> +       u64 reg_val;
> +
> +       reg_val =3D octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_CONTROL(iq_=
no));
> +
> +       /* wait for IDLE to set to 1 */
> +       if (!(reg_val & CNXK_VF_R_IN_CTL_IDLE)) {
> +               do {
> +                       reg_val =3D octep_vf_read_csr64(oct, CNXK_VF_SDP_=
R_IN_CONTROL(iq_no));
> +               } while (!(reg_val & CNXK_VF_R_IN_CTL_IDLE));
> +       }
> +       reg_val |=3D CNXK_VF_R_IN_CTL_RDSIZE;
> +       reg_val |=3D CNXK_VF_R_IN_CTL_IS_64B;
> +       reg_val |=3D CNXK_VF_R_IN_CTL_ESR;
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_CONTROL(iq_no), reg_va=
l);
> +
> +       /* Write the start of the input queue's ring and its size  */
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_INSTR_BADDR(iq_no), iq=
->desc_ring_dma);
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_INSTR_RSIZE(iq_no), iq=
->max_count);
> +
> +       /* Remember the doorbell & instruction count register addr for th=
is queue */
> +       iq->doorbell_reg =3D oct->mmio.hw_addr + CNXK_VF_SDP_R_IN_INSTR_D=
BELL(iq_no);
> +       iq->inst_cnt_reg =3D oct->mmio.hw_addr + CNXK_VF_SDP_R_IN_CNTS(iq=
_no);
> +       iq->intr_lvl_reg =3D oct->mmio.hw_addr + CNXK_VF_SDP_R_IN_INT_LEV=
ELS(iq_no);
> +
> +       /* Store the current instruction counter (used in flush_iq calcul=
ation) */
> +       reset_instr_cnt =3D readl(iq->inst_cnt_reg);
> +       writel(reset_instr_cnt, iq->inst_cnt_reg);
> +
> +       /* INTR_THRESHOLD is set to max(FFFFFFFF) to disable the INTR */
> +       reg_val =3D CFG_GET_IQ_INTR_THRESHOLD(oct->conf) & GENMASK_ULL(31=
, 0);
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_INT_LEVELS(iq_no), reg=
_val);
>  }
>
>  /* Setup registers for a hardware Rx Queue  */
>  static void octep_vf_setup_oq_regs_cnxk(struct octep_vf_device *oct, int=
 oq_no)
>  {
> +       struct octep_vf_oq *oq =3D oct->oq[oq_no];
> +       u32 time_threshold =3D 0;
> +       u64 oq_ctl =3D ULL(0);
> +       u64 reg_val;
> +
> +       reg_val =3D octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_CONTROL(oq=
_no));
> +
> +       /* wait for IDLE to set to 1 */
> +       if (!(reg_val & CNXK_VF_R_OUT_CTL_IDLE)) {
> +               do {
> +                       reg_val =3D octep_vf_read_csr64(oct, CNXK_VF_SDP_=
R_OUT_CONTROL(oq_no));
> +               } while (!(reg_val & CNXK_VF_R_OUT_CTL_IDLE));
> +       }
> +
> +       reg_val &=3D ~(CNXK_VF_R_OUT_CTL_IMODE);
> +       reg_val &=3D ~(CNXK_VF_R_OUT_CTL_ROR_P);
> +       reg_val &=3D ~(CNXK_VF_R_OUT_CTL_NSR_P);
> +       reg_val &=3D ~(CNXK_VF_R_OUT_CTL_ROR_I);
> +       reg_val &=3D ~(CNXK_VF_R_OUT_CTL_NSR_I);
> +       reg_val &=3D ~(CNXK_VF_R_OUT_CTL_ES_I);
> +       reg_val &=3D ~(CNXK_VF_R_OUT_CTL_ROR_D);
> +       reg_val &=3D ~(CNXK_VF_R_OUT_CTL_NSR_D);
> +       reg_val &=3D ~(CNXK_VF_R_OUT_CTL_ES_D);
> +       reg_val |=3D (CNXK_VF_R_OUT_CTL_ES_P);
> +
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_CONTROL(oq_no), reg_v=
al);
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_BADDR(oq_no), o=
q->desc_ring_dma);
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_RSIZE(oq_no), o=
q->max_count);
> +
> +       oq_ctl =3D octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_CONTROL(oq_=
no));
> +       /* Clear the ISIZE and BSIZE (22-0) */
> +       oq_ctl &=3D ~GENMASK_ULL(22, 0);
> +       /* Populate the BSIZE (15-0) */
> +       oq_ctl |=3D (oq->buffer_size & GENMASK_ULL(15, 0));
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_CONTROL(oq_no), oq_ct=
l);
> +
> +       /* Get the mapped address of the pkt_sent and pkts_credit regs */
> +       oq->pkts_sent_reg =3D oct->mmio.hw_addr + CNXK_VF_SDP_R_OUT_CNTS(=
oq_no);
> +       oq->pkts_credit_reg =3D oct->mmio.hw_addr + CNXK_VF_SDP_R_OUT_SLI=
ST_DBELL(oq_no);
> +
> +       time_threshold =3D CFG_GET_OQ_INTR_TIME(oct->conf);
> +       reg_val =3D ((u64)time_threshold << 32) | CFG_GET_OQ_INTR_PKT(oct=
->conf);
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_INT_LEVELS(oq_no), re=
g_val);
> +
> +       /* set watermark for backpressure */
> +       reg_val =3D octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_WMARK(oq_n=
o));
> +       reg_val &=3D ~GENMASK_ULL(31, 0);
> +       reg_val |=3D CFG_GET_OQ_WMARK(oct->conf);
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_WMARK(oq_no), reg_val=
);
>  }
>
>  /* Setup registers for a VF mailbox */
>  static void octep_vf_setup_mbox_regs_cnxk(struct octep_vf_device *oct, i=
nt q_no)
>  {
> +       struct octep_vf_mbox *mbox =3D oct->mbox;
> +
> +       /* PF to VF DATA reg. VF reads from this reg */
> +       mbox->mbox_read_reg =3D oct->mmio.hw_addr + CNXK_VF_SDP_R_MBOX_PF=
_VF_DATA(q_no);
> +
> +       /* VF mbox interrupt reg */
> +       mbox->mbox_int_reg =3D oct->mmio.hw_addr + CNXK_VF_SDP_R_MBOX_PF_=
VF_INT(q_no);
> +
> +       /* VF to PF DATA reg. VF writes into this reg */
> +       mbox->mbox_write_reg =3D oct->mmio.hw_addr + CNXK_VF_SDP_R_MBOX_V=
F_PF_DATA(q_no);
> +}
> +
> +/* Mailbox Interrupt handler */
> +static void cnxk_handle_vf_mbox_intr(struct octep_vf_device *oct)
> +{
> +       if (oct->mbox)
> +               schedule_work(&oct->mbox->wk.work);
> +       else
> +               dev_err(&oct->pdev->dev, "cannot schedule work on invalid=
 mbox\n");
>  }
>
>  /* Tx/Rx queue interrupt handler */
>  static irqreturn_t octep_vf_ioq_intr_handler_cnxk(void *data)
>  {
> +       struct octep_vf_ioq_vector *vector =3D data;
> +       struct octep_vf_device *oct;
> +       struct octep_vf_oq *oq;
> +       u64 reg_val =3D ULL(0);
> +
> +       oct =3D vector->octep_vf_dev;
> +       oq =3D vector->oq;
> +       /* Mailbox interrupt arrives along with interrupt of tx/rx ring p=
air 0 */
> +       if (oq->q_no =3D=3D 0) {
> +               reg_val =3D octep_vf_read_csr64(oct, CNXK_VF_SDP_R_MBOX_P=
F_VF_INT(0));
> +               if (reg_val & CNXK_VF_SDP_R_MBOX_PF_VF_INT_STATUS) {
> +                       cnxk_handle_vf_mbox_intr(oct);
> +                       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_MBOX_PF_V=
F_INT(0), reg_val);
> +               }
> +       }
> +       napi_schedule_irqoff(oq->napi);
>         return IRQ_HANDLED;
>  }
>
>  /* Re-initialize Octeon hardware registers */
>  static void octep_vf_reinit_regs_cnxk(struct octep_vf_device *oct)
>  {
> +       u32 i;
> +
> +       for (i =3D 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++)
> +               oct->hw_ops.setup_iq_regs(oct, i);
> +
> +       for (i =3D 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++)
> +               oct->hw_ops.setup_oq_regs(oct, i);
> +
> +       oct->hw_ops.enable_interrupts(oct);
> +       oct->hw_ops.enable_io_queues(oct);
> +
> +       for (i =3D 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++)
> +               writel(oct->oq[i]->max_count, oct->oq[i]->pkts_credit_reg=
);
>  }
>
>  /* Enable all interrupts */
>  static void octep_vf_enable_interrupts_cnxk(struct octep_vf_device *oct)
>  {
> +       int num_rings, q;
> +       u64 reg_val;
> +
> +       num_rings =3D CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
> +       for (q =3D 0; q < num_rings; q++) {
> +               reg_val =3D octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_INT=
_LEVELS(q));
> +               reg_val |=3D BIT_ULL_MASK(62);
> +               octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_INT_LEVELS(q),=
 reg_val);
> +
> +               reg_val =3D octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_IN=
T_LEVELS(q));
> +               reg_val |=3D BIT_ULL_MASK(62);
> +               octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_INT_LEVELS(q)=
, reg_val);
> +       }
> +       /* Enable PF to VF mbox interrupt by setting 2nd bit*/
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_MBOX_PF_VF_INT(0),
> +                            CNXK_VF_SDP_R_MBOX_PF_VF_INT_ENAB);
>  }
>
>  /* Disable all interrupts */
>  static void octep_vf_disable_interrupts_cnxk(struct octep_vf_device *oct=
)
>  {
> +       int num_rings, q;
> +       u64 reg_val;
> +
> +       /* Disable PF to VF mbox interrupt by setting 2nd bit*/
> +       if (oct->mbox)
> +               octep_vf_write_csr64(oct, CNXK_VF_SDP_R_MBOX_PF_VF_INT(0)=
, 0x0);
> +
> +       num_rings =3D CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
> +       for (q =3D 0; q < num_rings; q++) {
> +               reg_val =3D octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_INT=
_LEVELS(q));
> +               reg_val &=3D ~BIT_ULL_MASK(62);
> +               octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_INT_LEVELS(q),=
 reg_val);
> +
> +               reg_val =3D octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_IN=
T_LEVELS(q));
> +               reg_val &=3D ~BIT_ULL_MASK(62);
> +               octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_INT_LEVELS(q)=
, reg_val);
> +       }
>  }
>
>  /* Get new Octeon Read Index: index of descriptor that Octeon reads next=
. */
>  static u32 octep_vf_update_iq_read_index_cnxk(struct octep_vf_iq *iq)
>  {
> -       return 0;
> +       u32 pkt_in_done =3D readl(iq->inst_cnt_reg);
> +       u32 last_done, new_idx;
> +
> +       last_done =3D pkt_in_done - iq->pkt_in_done;
> +       iq->pkt_in_done =3D pkt_in_done;
> +
> +       new_idx =3D (iq->octep_vf_read_index + last_done) % iq->max_count=
;
> +
> +       return new_idx;
>  }
>
>  /* Enable a hardware Tx Queue */
>  static void octep_vf_enable_iq_cnxk(struct octep_vf_device *oct, int iq_=
no)
>  {
> +       u64 loop =3D HZ;
> +       u64 reg_val;
> +
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_INSTR_DBELL(iq_no), GE=
NMASK_ULL(31, 0));
> +
> +       while (octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_INSTR_DBELL(iq_n=
o)) &&
> +              loop--) {
> +               schedule_timeout_interruptible(1);
> +       }
> +
> +       reg_val =3D octep_vf_read_csr64(oct,  CNXK_VF_SDP_R_IN_INT_LEVELS=
(iq_no));
> +       reg_val |=3D BIT_ULL_MASK(62);
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_INT_LEVELS(iq_no), reg=
_val);
> +
> +       reg_val =3D octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_ENABLE(iq_n=
o));
> +       reg_val |=3D ULL(1);
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_ENABLE(iq_no), reg_val=
);
>  }
>
>  /* Enable a hardware Rx Queue */
>  static void octep_vf_enable_oq_cnxk(struct octep_vf_device *oct, int oq_=
no)
>  {
> +       u64 reg_val =3D ULL(0);
> +
> +       reg_val =3D octep_vf_read_csr64(oct,  CNXK_VF_SDP_R_OUT_INT_LEVEL=
S(oq_no));
> +       reg_val |=3D BIT_ULL_MASK(62);
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_INT_LEVELS(oq_no), re=
g_val);
> +
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_DBELL(oq_no), G=
ENMASK_ULL(31, 0));
> +
> +       reg_val =3D octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_ENABLE(oq_=
no));
> +       reg_val |=3D ULL(1);
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_ENABLE(oq_no), reg_va=
l);
>  }
>
>  /* Enable all hardware Tx/Rx Queues assigned to VF */
>  static void octep_vf_enable_io_queues_cnxk(struct octep_vf_device *oct)
>  {
> +       u8 q;
> +
> +       for (q =3D 0; q < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); q++) =
{
> +               octep_vf_enable_iq_cnxk(oct, q);
> +               octep_vf_enable_oq_cnxk(oct, q);
> +       }
>  }
>
>  /* Disable a hardware Tx Queue assigned to VF */
>  static void octep_vf_disable_iq_cnxk(struct octep_vf_device *oct, int iq=
_no)
>  {
> +       u64 reg_val =3D ULL(0);
> +
> +       reg_val =3D octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_ENABLE(iq_n=
o));
> +       reg_val &=3D ~ULL(1);
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_ENABLE(iq_no), reg_val=
);
>  }
>
>  /* Disable a hardware Rx Queue assigned to VF */
>  static void octep_vf_disable_oq_cnxk(struct octep_vf_device *oct, int oq=
_no)
>  {
> +       u64 reg_val =3D ULL(0);
> +
> +       reg_val =3D octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_ENABLE(oq_=
no));
> +       reg_val &=3D ~ULL(1);
> +       octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_ENABLE(oq_no), reg_va=
l);
>  }
>
>  /* Disable all hardware Tx/Rx Queues assigned to VF */
>  static void octep_vf_disable_io_queues_cnxk(struct octep_vf_device *oct)
>  {
> +       int q =3D 0;
> +
> +       for (q =3D 0; q < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); q++) =
{
> +               octep_vf_disable_iq_cnxk(oct, q);
> +               octep_vf_disable_oq_cnxk(oct, q);
> +       }
>  }
>
>  /* Dump hardware registers (including Tx/Rx queues) for debugging. */
>  static void octep_vf_dump_registers_cnxk(struct octep_vf_device *oct)
>  {
> +       u8 num_rings, q;
> +
> +       num_rings =3D CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
> +       for (q =3D 0; q < num_rings; q++)
> +               cnxk_vf_dump_q_regs(oct, q);
>  }
>
>  /**
> --
> 2.25.1
>
>


--=20
Regards,
Kalesh A P

--000000000000e9e023060e6fab2e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIOidpWpfKVOlUfQxYT/ell41gD85RZPYgSl/NQjfUysGMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDEwODE0MDQwOFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBaT6VrMe8w
e80XB0G885e5Ar0QNrll+Isr2tk0425ZA4KYJMbifRBlLVbIHbe0oHO+NHH6c2EjKh2TT253xK6j
Q4PZnBdWbyPf1HMCoq67MrdENTap7zaxEnBJ79UGTmdHHtOGTWuvmPw8ydMZF+uvFkXwvdn8u3nw
yaMFZT2JQxb1Ugnz4nJgfYIG0Z7ljWvh3UQGuRnxwt+eKJ41AQAMu4SIS+r/IeESWS3XEiRmtor/
eeeJo2w+/gaVdWXL9usgpjJAHYLspycLwwBPCW70CJZ+IEJr5MlnwBeyld5Nq8eG/jUvCGwRX53i
fPnqL9p2qdSTyA3To+OMp5/6ipSc
--000000000000e9e023060e6fab2e--

