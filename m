Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59EF76742E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbjG1SDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjG1SDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:03:35 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8442B4234
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:03:32 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-63d03d3cac6so12745106d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1690567411; x=1691172211;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JY3x92vCbRXuaEIVQVzsq7HHw8a5GpA+oG2oGl/1VaA=;
        b=lk8GCeYM5AadCy1ujPwRY67lLO5aCysjutJ72lgeaTGRj+Vh9ufysMpfEy9o4pT3wU
         BfTIhCQBBRZJzmzuZyqkjiEySy/HUoPeg3ITP78v9Ba8nJfqCN9KnsoTRQYDoEPGg2RA
         1yhhg0jj9zKtSN4csccktamd4Nta+ivBNQAEKnGGa6VQTMd3VxeQ5dUtBLa2PfJoTTYA
         LDdX4h7MfSQNJe7lxVjQNnA1ULJdxGHri+4bMr43yF3l2VLfh85qwj//9XqYY16IO9s9
         3J/GqPXHNs7VDfIn2ajbWIHgETVSstijnmbmhU/6YcD/XZ37KcEvXu/roiQqlIACHDCS
         zLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690567411; x=1691172211;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JY3x92vCbRXuaEIVQVzsq7HHw8a5GpA+oG2oGl/1VaA=;
        b=XlvTOqC4YeQ2Z3tCc3O4CGutUDs+SfRtgagKB2mIc25Evtv+hmR3qdFYIq++OSi2LR
         GsN7PvAIbIJoT7yT1/IEIM3NBxHewR6AF8iT9kHqaPE+JpoSbxTUkwr5pP+qmQ6mpQKB
         lPfe5vE/qJh1NV208W1CUyU0FAg7IvjhnGnccp5AOEnZxUQ5tXr+QvK+KXvMFn3p3tN5
         xE+Rx+zt+n2YMBEaKMUSB6s6Th5ScD0l0NHp70PKvSPxxmIpojweOWr8mokQ8hk5bNWh
         TrJe6mIBC/ns8hV2XH0jKE1pFWtYRXMkuCZdXtnXie5H7pAsGZSW5goAm9Ozc+233PY3
         eiNA==
X-Gm-Message-State: ABy/qLal31TsB+lhLTFtAA5S34E6TY9d7dehW1PVi7yzb2q4LXGVofgm
        PyH57VMxVveaCrIvHNHTZkjVqA==
X-Google-Smtp-Source: APBJJlH63cUdfHzn+LWhC2UPuB6SfTo9njZSycZMCom72pj/5YCCKpAG9omjlSyq2a9VXnuJvGOUNQ==
X-Received: by 2002:a0c:9a99:0:b0:63d:580:9c64 with SMTP id y25-20020a0c9a99000000b0063d05809c64mr3336243qvd.46.1690567411509;
        Fri, 28 Jul 2023 11:03:31 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:10:2688::7a9])
        by smtp.gmail.com with ESMTPSA id o2-20020a0ce402000000b0063d14bfa5absm1421595qvl.36.2023.07.28.11.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 11:03:31 -0700 (PDT)
Message-ID: <5e61d8ed25d74b242b0ac7ccc6f825861f0cbc68.camel@ndufresne.ca>
Subject: Re: [PATCH 05/33] iris: vidc: add vb2 ops
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     quic_dikshita@quicinc.com
Date:   Fri, 28 Jul 2023 14:03:30 -0400
In-Reply-To: <1690550624-14642-6-git-send-email-quic_vgarodia@quicinc.com>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
         <1690550624-14642-6-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 28 juillet 2023 =C3=A0 18:53 +0530, Vikash Garodia a =C3=A9crit=
=C2=A0:
> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
>=20
> This implements vb2 ops for streaming modes for
> alloc, free, map and unmap buffers.
>=20
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>  .../platform/qcom/iris/vidc/inc/msm_vidc_vb2.h     |  39 ++
>  .../platform/qcom/iris/vidc/src/msm_vidc_vb2.c     | 605 +++++++++++++++=
++++++
>  2 files changed, 644 insertions(+)
>  create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_vb=
2.h
>  create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_vb=
2.c
>=20
> diff --git a/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_vb2.h b/d=
rivers/media/platform/qcom/iris/vidc/inc/msm_vidc_vb2.h
> new file mode 100644
> index 0000000..12378ce
> --- /dev/null
> +++ b/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_vb2.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserv=
ed.
> + */
> +
> +#ifndef _MSM_VIDC_VB2_H_
> +#define _MSM_VIDC_VB2_H_
> +
> +#include <media/videobuf2-core.h>
> +#include <media/videobuf2-v4l2.h>
> +
> +#include "msm_vidc_inst.h"
> +
> +struct vb2_queue *msm_vidc_get_vb2q(struct msm_vidc_inst *inst,
> +				    u32 type, const char *func);
> +
> +/* vb2_mem_ops */
> +void *msm_vb2_alloc(struct vb2_buffer *vb, struct device *dev,
> +		    unsigned long size);
> +void *msm_vb2_attach_dmabuf(struct vb2_buffer *vb, struct device *dev,
> +			    struct dma_buf *dbuf, unsigned long size);
> +
> +void msm_vb2_put(void *buf_priv);
> +int msm_vb2_mmap(void *buf_priv, struct vm_area_struct *vma);
> +void msm_vb2_detach_dmabuf(void *buf_priv);
> +int msm_vb2_map_dmabuf(void *buf_priv);
> +void msm_vb2_unmap_dmabuf(void *buf_priv);
> +
> +/* vb2_ops */
> +int msm_vb2_queue_setup(struct vb2_queue *q,
> +			unsigned int *num_buffers, unsigned int *num_planes,
> +			unsigned int sizes[], struct device *alloc_devs[]);
> +int msm_vidc_start_streaming(struct msm_vidc_inst *inst, struct vb2_queu=
e *q);
> +int msm_vidc_stop_streaming(struct msm_vidc_inst *inst, struct vb2_queue=
 *q);
> +int msm_vb2_start_streaming(struct vb2_queue *q, unsigned int count);
> +void msm_vb2_stop_streaming(struct vb2_queue *q);
> +void msm_vb2_buf_queue(struct vb2_buffer *vb2);
> +#endif // _MSM_VIDC_VB2_H_
> diff --git a/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_vb2.c b/d=
rivers/media/platform/qcom/iris/vidc/src/msm_vidc_vb2.c
> new file mode 100644
> index 0000000..c936d95
> --- /dev/null
> +++ b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_vb2.c
> @@ -0,0 +1,605 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights r=
eserved.
> + */
> +
> +#include "msm_vdec.h"
> +#include "msm_venc.h"
> +#include "msm_vidc_control.h"
> +#include "msm_vidc_core.h"
> +#include "msm_vidc_debug.h"
> +#include "msm_vidc_driver.h"
> +#include "msm_vidc_inst.h"
> +#include "msm_vidc_internal.h"
> +#include "msm_vidc_platform.h"
> +#include "msm_vidc_power.h"
> +#include "msm_vidc_vb2.h"
> +
> +struct vb2_queue *msm_vidc_get_vb2q(struct msm_vidc_inst *inst,
> +				    u32 type, const char *func)
> +{
> +	struct vb2_queue *q =3D NULL;
> +
> +	if (type =3D=3D INPUT_MPLANE) {
> +		q =3D inst->bufq[INPUT_PORT].vb2q;
> +	} else if (type =3D=3D OUTPUT_MPLANE) {
> +		q =3D inst->bufq[OUTPUT_PORT].vb2q;
> +	} else {
> +		i_vpr_e(inst, "%s: invalid buffer type %d\n",
> +			__func__, type);
> +	}
> +	return q;
> +}
> +
> +void *msm_vb2_alloc(struct vb2_buffer *vb, struct device *dev,
> +		    unsigned long size)
> +{
> +	return (void *)0xdeadbeef;
> +}
> +
> +void *msm_vb2_attach_dmabuf(struct vb2_buffer *vb, struct device *dev,
> +			    struct dma_buf *dbuf, unsigned long size)
> +{
> +	struct msm_vidc_inst *inst;
> +	struct msm_vidc_core *core;
> +	struct msm_vidc_buffer *buf =3D NULL;
> +	struct msm_vidc_buffer *ro_buf, *dummy;
> +
> +	if (!vb || !dev || !dbuf || !vb->vb2_queue) {
> +		d_vpr_e("%s: invalid params\n", __func__);
> +		return NULL;
> +	}
> +	inst =3D vb->vb2_queue->drv_priv;
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !inst->core) {
> +		d_vpr_e("%s: invalid params %pK\n", __func__, inst);
> +		return NULL;
> +	}
> +	core =3D inst->core;
> +
> +	buf =3D msm_vidc_fetch_buffer(inst, vb);
> +	if (!buf) {
> +		i_vpr_e(inst, "%s: failed to fetch buffer\n", __func__);
> +		buf =3D NULL;
> +		goto exit;
> +	}
> +	buf->inst =3D inst;
> +	buf->dmabuf =3D dbuf;
> +
> +	if (is_decode_session(inst) && is_output_buffer(buf->type)) {
> +		list_for_each_entry_safe(ro_buf, dummy, &inst->buffers.read_only.list,=
 list) {
> +			if (ro_buf->dmabuf !=3D buf->dmabuf)
> +				continue;
> +			print_vidc_buffer(VIDC_LOW, "low ", "attach: found ro buf", inst, ro_=
buf);
> +			buf->attach =3D ro_buf->attach;
> +			ro_buf->attach =3D NULL;
> +			goto exit;
> +		}
> +	}
> +
> +	buf->attach =3D call_mem_op(core, dma_buf_attach, core, dbuf, dev);
> +	if (!buf->attach) {
> +		buf->attach =3D NULL;
> +		buf =3D NULL;
> +		goto exit;
> +	}
> +	print_vidc_buffer(VIDC_LOW, "low ", "attach", inst, buf);
> +
> +exit:
> +	if (!buf)
> +		msm_vidc_change_state(inst, MSM_VIDC_ERROR, __func__);
> +	put_inst(inst);
> +	return buf;
> +}
> +
> +void msm_vb2_put(void *buf_priv)
> +{
> +}
> +
> +int msm_vb2_mmap(void *buf_priv, struct vm_area_struct *vma)
> +{
> +	return 0;
> +}
> +
> +void msm_vb2_detach_dmabuf(void *buf_priv)
> +{
> +	struct msm_vidc_buffer *vbuf =3D buf_priv;
> +	struct msm_vidc_buffer *ro_buf, *dummy;
> +	struct msm_vidc_core *core;
> +	struct msm_vidc_inst *inst;
> +
> +	if (!vbuf || !vbuf->inst) {
> +		d_vpr_e("%s: invalid params\n", __func__);
> +		return;
> +	}
> +	inst =3D vbuf->inst;
> +	if (!inst || !inst->core) {
> +		d_vpr_e("%s: invalid params %pK\n", __func__, inst);
> +		return;
> +	}
> +	core =3D inst->core;
> +
> +	if (is_decode_session(inst) && is_output_buffer(vbuf->type)) {
> +		list_for_each_entry_safe(ro_buf, dummy, &inst->buffers.read_only.list,=
 list) {
> +			if (ro_buf->dmabuf !=3D vbuf->dmabuf)
> +				continue;
> +			print_vidc_buffer(VIDC_LOW, "low ", "detach: found ro buf", inst, ro_=
buf);
> +			ro_buf->attach =3D vbuf->attach;
> +			vbuf->attach =3D NULL;
> +			goto exit;
> +		}
> +	}
> +
> +	print_vidc_buffer(VIDC_LOW, "low ", "detach", inst, vbuf);
> +	if (vbuf->attach && vbuf->dmabuf) {
> +		call_mem_op(core, dma_buf_detach, core, vbuf->dmabuf, vbuf->attach);
> +		vbuf->attach =3D NULL;
> +	}
> +
> +exit:
> +	vbuf->dmabuf =3D NULL;
> +	vbuf->inst =3D NULL;
> +}
> +
> +int msm_vb2_map_dmabuf(void *buf_priv)
> +{
> +	int rc =3D 0;
> +	struct msm_vidc_buffer *buf =3D buf_priv;
> +	struct msm_vidc_core *core;
> +	struct msm_vidc_inst *inst;
> +	struct msm_vidc_buffer *ro_buf, *dummy;
> +
> +	if (!buf || !buf->inst) {
> +		d_vpr_e("%s: invalid params\n", __func__);
> +		return -EINVAL;
> +	}
> +	inst =3D buf->inst;
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !inst->core) {
> +		d_vpr_e("%s: invalid params\n", __func__);
> +		return -EINVAL;
> +	}
> +	core =3D inst->core;
> +
> +	if (is_decode_session(inst) && is_output_buffer(buf->type)) {
> +		list_for_each_entry_safe(ro_buf, dummy, &inst->buffers.read_only.list,=
 list) {
> +			if (ro_buf->dmabuf !=3D buf->dmabuf)
> +				continue;
> +			print_vidc_buffer(VIDC_LOW, "low ", "map: found ro buf", inst, ro_buf=
);
> +			buf->sg_table =3D ro_buf->sg_table;
> +			buf->device_addr =3D ro_buf->device_addr;
> +			ro_buf->sg_table =3D NULL;
> +			goto exit;
> +		}
> +	}
> +
> +	buf->sg_table =3D call_mem_op(core, dma_buf_map_attachment, core, buf->=
attach);
> +	if (!buf->sg_table || !buf->sg_table->sgl) {
> +		buf->sg_table =3D NULL;
> +		rc =3D -ENOMEM;
> +		goto exit;
> +	}
> +	buf->device_addr =3D sg_dma_address(buf->sg_table->sgl);
> +	print_vidc_buffer(VIDC_HIGH, "high", "map", inst, buf);
> +
> +exit:
> +	if (rc)
> +		msm_vidc_change_state(inst, MSM_VIDC_ERROR, __func__);
> +	put_inst(inst);
> +	return rc;
> +}
> +
> +void msm_vb2_unmap_dmabuf(void *buf_priv)
> +{
> +	struct msm_vidc_buffer *vbuf =3D buf_priv;
> +	struct msm_vidc_buffer *ro_buf, *dummy;
> +	struct msm_vidc_core *core;
> +	struct msm_vidc_inst *inst;
> +
> +	if (!vbuf || !vbuf->inst) {
> +		d_vpr_e("%s: invalid params\n", __func__);
> +		return;
> +	}
> +	inst =3D vbuf->inst;
> +	if (!inst || !inst->core) {
> +		d_vpr_e("%s: invalid params %pK\n", __func__, inst);
> +		return;
> +	}
> +	core =3D inst->core;
> +
> +	if (is_decode_session(inst) && is_output_buffer(vbuf->type)) {
> +		list_for_each_entry_safe(ro_buf, dummy, &inst->buffers.read_only.list,=
 list) {
> +			if (ro_buf->dmabuf !=3D vbuf->dmabuf)
> +				continue;
> +			print_vidc_buffer(VIDC_LOW, "low ", "unmap: found ro buf", inst, ro_b=
uf);
> +			ro_buf->sg_table =3D vbuf->sg_table;
> +			vbuf->sg_table =3D NULL;
> +			vbuf->device_addr =3D 0x0;
> +			goto exit;
> +		}
> +	}
> +
> +	print_vidc_buffer(VIDC_HIGH, "high", "unmap", inst, vbuf);
> +	if (vbuf->attach && vbuf->sg_table) {
> +		call_mem_op(core, dma_buf_unmap_attachment, core, vbuf->attach, vbuf->=
sg_table);
> +		vbuf->sg_table =3D NULL;
> +		vbuf->device_addr =3D 0x0;
> +	}
> +
> +exit:
> +	return;
> +}
> +
> +int msm_vb2_queue_setup(struct vb2_queue *q,
> +			unsigned int *num_buffers, unsigned int *num_planes,
> +			unsigned int sizes[], struct device *alloc_devs[])
> +{
> +	int rc =3D 0;
> +	struct msm_vidc_inst *inst;
> +	struct msm_vidc_core *core;
> +	int port;
> +	struct v4l2_format *f;
> +	enum msm_vidc_buffer_type buffer_type =3D 0;
> +	enum msm_vidc_buffer_region region =3D MSM_VIDC_REGION_NONE;
> +	struct context_bank_info *cb =3D NULL;
> +	struct msm_vidc_buffers *buffers;
> +
> +	if (!q || !num_buffers || !num_planes ||
> +	    !sizes || !q->drv_priv) {
> +		d_vpr_e("%s: invalid params, q =3D %pK, %pK, %pK\n",
> +			__func__, q, num_buffers, num_planes);
> +		return -EINVAL;
> +	}
> +	inst =3D q->drv_priv;
> +	if (!inst || !inst->core) {
> +		d_vpr_e("%s: invalid params %pK\n", __func__, inst);
> +		return -EINVAL;
> +	}
> +	core =3D inst->core;
> +
> +	if (is_state(inst, MSM_VIDC_STREAMING)) {
> +		i_vpr_e(inst, "%s: invalid state %d\n", __func__, inst->state);
> +		return -EINVAL;
> +	}
> +
> +	port =3D v4l2_type_to_driver_port(inst, q->type, __func__);
> +	if (port < 0)
> +		return -EINVAL;
> +
> +	/* prepare dependency list once per session */
> +	if (!inst->caps_list_prepared) {
> +		rc =3D msm_vidc_prepare_dependency_list(inst);
> +		if (rc)
> +			return rc;
> +		inst->caps_list_prepared =3D true;
> +	}
> +
> +	/* adjust v4l2 properties for master port */
> +	if ((is_encode_session(inst) && port =3D=3D OUTPUT_PORT) ||
> +	    (is_decode_session(inst) && port =3D=3D INPUT_PORT)) {
> +		rc =3D msm_vidc_adjust_v4l2_properties(inst);
> +		if (rc) {
> +			i_vpr_e(inst, "%s: failed to adjust properties\n", __func__);
> +			return rc;
> +		}
> +	}
> +
> +	if (*num_planes && (port =3D=3D INPUT_PORT || port =3D=3D OUTPUT_PORT))=
 {
> +		f =3D &inst->fmts[port];
> +		if (*num_planes !=3D f->fmt.pix_mp.num_planes) {
> +			i_vpr_e(inst, "%s: requested num_planes %d not supported %d\n",
> +				__func__, *num_planes, f->fmt.pix_mp.num_planes);
> +			return -EINVAL;
> +		}
> +		if (sizes[0] < inst->fmts[port].fmt.pix_mp.plane_fmt[0].sizeimage) {
> +			i_vpr_e(inst, "%s: requested size %d not acceptable\n",
> +				__func__, sizes[0]);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	buffer_type =3D v4l2_type_to_driver(q->type, __func__);
> +	if (!buffer_type)
> +		return -EINVAL;
> +
> +	rc =3D msm_vidc_free_buffers(inst, buffer_type);
> +	if (rc) {
> +		i_vpr_e(inst, "%s: failed to free buffers, type %s\n",
> +			__func__, v4l2_type_name(q->type));
> +		return rc;
> +	}
> +
> +	buffers =3D msm_vidc_get_buffers(inst, buffer_type, __func__);
> +	if (!buffers)
> +		return -EINVAL;
> +
> +	buffers->min_count =3D call_session_op(core, min_count, inst, buffer_ty=
pe);
> +	buffers->extra_count =3D call_session_op(core, extra_count, inst, buffe=
r_type);
> +	if (*num_buffers < buffers->min_count + buffers->extra_count)
> +		*num_buffers =3D buffers->min_count + buffers->extra_count;
> +	buffers->actual_count =3D *num_buffers;
> +	*num_planes =3D 1;
> +
> +	buffers->size =3D call_session_op(core, buffer_size, inst, buffer_type)=
;
> +
> +	inst->fmts[port].fmt.pix_mp.plane_fmt[0].sizeimage =3D buffers->size;
> +	sizes[0] =3D inst->fmts[port].fmt.pix_mp.plane_fmt[0].sizeimage;
> +
> +	rc =3D msm_vidc_allocate_buffers(inst, buffer_type, *num_buffers);
> +	if (rc) {
> +		i_vpr_e(inst, "%s: failed to allocate buffers, type %s\n",
> +			__func__, v4l2_type_name(q->type));
> +		return rc;
> +	}
> +
> +	region =3D call_mem_op(core, buffer_region, inst, buffer_type);
> +	cb =3D msm_vidc_get_context_bank_for_region(core, region);
> +	if (!cb) {
> +		d_vpr_e("%s: Failed to get context bank device\n",
> +			__func__);
> +		return -EIO;
> +	}
> +	q->dev =3D cb->dev;
> +
> +	i_vpr_h(inst,
> +		"queue_setup: type %s num_buffers %d sizes[0] %d cb %s\n",
> +		v4l2_type_name(q->type), *num_buffers, sizes[0], cb->name);
> +	return rc;
> +}
> +
> +int msm_vb2_start_streaming(struct vb2_queue *q, unsigned int count)
> +{
> +	int rc =3D 0;
> +	struct msm_vidc_inst *inst;
> +
> +	if (!q || !q->drv_priv) {
> +		d_vpr_e("%s: invalid input, q =3D %pK\n", __func__, q);
> +		return -EINVAL;
> +	}
> +	inst =3D q->drv_priv;
> +	if (!inst || !inst->core) {
> +		d_vpr_e("%s: invalid params\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	rc =3D inst->event_handle(inst, MSM_VIDC_STREAMON, q);
> +	if (rc) {
> +		i_vpr_e(inst, "Streamon: %s failed\n", v4l2_type_name(q->type));
> +		msm_vidc_change_state(inst, MSM_VIDC_ERROR, __func__);
> +		goto exit;
> +	}
> +
> +exit:
> +	return rc;
> +}
> +
> +int msm_vidc_start_streaming(struct msm_vidc_inst *inst, struct vb2_queu=
e *q)
> +{
> +	enum msm_vidc_buffer_type buf_type;
> +	int rc =3D 0;
> +
> +	if (q->type !=3D INPUT_MPLANE && q->type !=3D OUTPUT_MPLANE) {
> +		i_vpr_e(inst, "%s: invalid type %d\n", __func__, q->type);
> +		return -EINVAL;
> +	}
> +	if (!is_decode_session(inst) && !is_encode_session(inst)) {
> +		i_vpr_e(inst, "%s: invalid session %d\n", __func__, inst->domain);
> +		return -EINVAL;
> +	}
> +	i_vpr_h(inst, "Streamon: %s\n", v4l2_type_name(q->type));
> +
> +	if (!inst->once_per_session_set) {

This seems miss-placed, I think you should be able to move this into your d=
river
open() call and drop the inst->once_per_session_set boolean.

> +		inst->once_per_session_set =3D true;
> +		rc =3D msm_vidc_session_set_codec(inst);
> +		if (rc)
> +			return rc;
> +
> +		if (is_encode_session(inst)) {
> +			rc =3D msm_vidc_alloc_and_queue_session_int_bufs(inst,
> +								       MSM_VIDC_BUF_ARP);
> +			if (rc)
> +				return rc;
> +		} else if (is_decode_session(inst)) {
> +			rc =3D msm_vidc_session_set_default_header(inst);
> +			if (rc)
> +				return rc;
> +
> +			rc =3D msm_vidc_alloc_and_queue_session_int_bufs(inst,
> +								       MSM_VIDC_BUF_PERSIST);
> +			if (rc)
> +				return rc;
> +		}
> +	}
> +
> +	if (is_decode_session(inst))
> +		inst->decode_batch.enable =3D msm_vidc_allow_decode_batch(inst);
> +
> +	msm_vidc_allow_dcvs(inst);
> +	msm_vidc_power_data_reset(inst);
> +
> +	if (q->type =3D=3D INPUT_MPLANE) {
> +		if (is_decode_session(inst))
> +			rc =3D msm_vdec_streamon_input(inst);
> +		else if (is_encode_session(inst))
> +			rc =3D msm_venc_streamon_input(inst);
> +	} else if (q->type =3D=3D OUTPUT_MPLANE) {
> +		if (is_decode_session(inst))
> +			rc =3D msm_vdec_streamon_output(inst);
> +		else if (is_encode_session(inst))
> +			rc =3D msm_venc_streamon_output(inst);
> +	}
> +	if (rc)
> +		return rc;
> +
> +	/* print final buffer counts & size details */
> +	msm_vidc_print_buffer_info(inst);
> +
> +	/* print internal buffer memory usage stats */
> +	msm_vidc_print_memory_stats(inst);
> +
> +	buf_type =3D v4l2_type_to_driver(q->type, __func__);
> +	if (!buf_type)
> +		return -EINVAL;
> +
> +	/* queue pending buffers */
> +	rc =3D msm_vidc_queue_deferred_buffers(inst, buf_type);
> +	if (rc)
> +		return rc;
> +
> +	/* initialize statistics timer(one time) */
> +	if (!inst->stats.time_ms)
> +		inst->stats.time_ms =3D ktime_get_ns() / 1000 / 1000;
> +
> +	/* schedule to print buffer statistics */
> +	rc =3D schedule_stats_work(inst);
> +	if (rc)
> +		return rc;
> +
> +	if ((q->type =3D=3D INPUT_MPLANE && inst->bufq[OUTPUT_PORT].vb2q->strea=
ming) ||
> +	    (q->type =3D=3D OUTPUT_MPLANE && inst->bufq[INPUT_PORT].vb2q->strea=
ming)) {
> +		rc =3D msm_vidc_get_properties(inst);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	i_vpr_h(inst, "Streamon: %s successful\n", v4l2_type_name(q->type));
> +	return rc;
> +}
> +
> +int msm_vidc_stop_streaming(struct msm_vidc_inst *inst, struct vb2_queue=
 *q)
> +{
> +	int rc =3D 0;
> +
> +	if (q->type !=3D INPUT_MPLANE && q->type !=3D OUTPUT_MPLANE) {
> +		i_vpr_e(inst, "%s: invalid type %d\n", __func__, q->type);
> +		return -EINVAL;
> +	}
> +	if (!is_decode_session(inst) && !is_encode_session(inst)) {
> +		i_vpr_e(inst, "%s: invalid session %d\n", __func__, inst->domain);
> +		return -EINVAL;
> +	}
> +	i_vpr_h(inst, "Streamoff: %s\n", v4l2_type_name(q->type));
> +
> +	if (q->type =3D=3D INPUT_MPLANE) {
> +		if (is_decode_session(inst))
> +			rc =3D msm_vdec_streamoff_input(inst);
> +		else if (is_encode_session(inst))
> +			rc =3D msm_venc_streamoff_input(inst);
> +	} else if (q->type =3D=3D OUTPUT_MPLANE) {
> +		if (is_decode_session(inst))
> +			rc =3D msm_vdec_streamoff_output(inst);
> +		else if (is_encode_session(inst))
> +			rc =3D msm_venc_streamoff_output(inst);
> +	}
> +	if (rc)
> +		return rc;
> +
> +	/* Input port streamoff */
> +	if (q->type =3D=3D INPUT_MPLANE) {
> +		/* flush timestamps list */
> +		msm_vidc_flush_ts(inst);
> +	}
> +
> +	/* print internal buffer memory usage stats */
> +	msm_vidc_print_memory_stats(inst);
> +
> +	i_vpr_h(inst, "Streamoff: %s successful\n", v4l2_type_name(q->type));
> +	return rc;
> +}
> +
> +void msm_vb2_stop_streaming(struct vb2_queue *q)
> +{
> +	struct msm_vidc_inst *inst;
> +	int rc =3D 0;
> +
> +	if (!q || !q->drv_priv) {
> +		d_vpr_e("%s: invalid input, q =3D %pK\n", __func__, q);
> +		return;
> +	}
> +	inst =3D q->drv_priv;
> +	if (!inst) {
> +		d_vpr_e("%s: invalid params\n", __func__);
> +		return;
> +	}
> +
> +	rc =3D inst->event_handle(inst, MSM_VIDC_STREAMOFF, q);
> +	if (rc) {
> +		i_vpr_e(inst, "Streamoff: %s failed\n", v4l2_type_name(q->type));
> +		msm_vidc_change_state(inst, MSM_VIDC_ERROR, __func__);
> +	}
> +}
> +
> +void msm_vb2_buf_queue(struct vb2_buffer *vb2)
> +{
> +	int rc =3D 0;
> +	struct msm_vidc_inst *inst;
> +	struct dma_buf *dbuf =3D NULL;
> +	struct msm_vidc_core *core;
> +	u64 ktime_ns =3D ktime_get_ns();
> +
> +	if (!vb2) {
> +		d_vpr_e("%s: invalid params\n", __func__);
> +		return;
> +	}
> +
> +	inst =3D vb2_get_drv_priv(vb2->vb2_queue);
> +	if (!inst || !inst->core) {
> +		d_vpr_e("%s: invalid params\n", __func__);
> +		return;
> +	}
> +	core =3D inst->core;
> +
> +	if (!vb2->planes[0].bytesused) {
> +		if (vb2->type =3D=3D INPUT_MPLANE) {
> +			/* Expecting non-zero filledlen on INPUT port */
> +			i_vpr_e(inst,
> +				"%s: zero bytesused input buffer not supported\n", __func__);
> +			rc =3D -EINVAL;
> +			goto exit;
> +		}
> +	}
> +
> +	inst->last_qbuf_time_ns =3D ktime_ns;
> +
> +	if (vb2->type =3D=3D INPUT_MPLANE) {
> +		rc =3D msm_vidc_update_input_rate(inst, div_u64(ktime_ns, 1000));
> +		if (rc)
> +			goto exit;
> +	}
> +
> +	/*
> +	 * Userspace may close fd(from other thread), before driver attempts to=
 call
> +	 * dma_buf_get() in qbuf(FTB) sequence(for decoder output buffer) which=
 may
> +	 * lead to different kind of security issues. Add check to compare if d=
ma_buf
> +	 * address is matching with driver dma_buf_get returned address for tha=
t fd.
> +	 */
> +
> +	dbuf =3D call_mem_op(core, dma_buf_get, inst, vb2->planes[0].m.fd);
> +	if (dbuf !=3D vb2->planes[0].dbuf) {
> +		i_vpr_e(inst, "%s: invalid dmabuf address 0x%p expected 0x%p\n",
> +			__func__, dbuf, vb2->planes[0].dbuf);
> +		rc =3D -EINVAL;
> +		goto exit;
> +	}
> +
> +	if (is_decode_session(inst))
> +		rc =3D msm_vdec_qbuf(inst, vb2);
> +	else if (is_encode_session(inst))
> +		rc =3D msm_venc_qbuf(inst, vb2);
> +	else
> +		rc =3D -EINVAL;
> +	if (rc) {
> +		print_vb2_buffer("failed vb2-qbuf", inst, vb2);
> +		goto exit;
> +	}
> +
> +exit:
> +	if (dbuf)
> +		call_mem_op(core, dma_buf_put, inst, dbuf);
> +
> +	if (rc) {
> +		msm_vidc_change_state(inst, MSM_VIDC_ERROR, __func__);
> +		vb2_buffer_done(vb2, VB2_BUF_STATE_ERROR);
> +	}
> +}

