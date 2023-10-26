Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9317D7BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 06:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbjJZE4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 00:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjJZE43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 00:56:29 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8077F93;
        Wed, 25 Oct 2023 21:56:26 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-777754138bdso39716185a.1;
        Wed, 25 Oct 2023 21:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698296185; x=1698900985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1j98rZpvN2vq/fHUHmpIc9b4uE1v2coS0MSrmodl+rM=;
        b=E9Wk9jRMa33/+0AYfiIYSED7+8s8qCt6K1Rq1YKKH3lSgOyzO8VWZwHpR1BR96YQW5
         JNcAXTluK2xKISr5P+tWT16prLLMXCWJGipjioDOCdaXyGU2vb+GuCsFLV0qhMBgf59d
         ZaWSm0BHrOf2tsiIxNtSxAsKG1rwRY4oTL0JrOi7z0lPCsawgfmrO2yafOHRoQzFcNO8
         KW+Ag2pgGLMu69hGU8Xhdgh3ygbhM0mxkm2J8vHt3nBcEMueQ8ocrD+8eqGuiI7zv4Nt
         bxqIewUUbr08AlhFbq8M91PkEpxWbBx1AYsJ/GW4PovwO1PTtMWgXF2gf6k2VrH7ncXi
         ZClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698296185; x=1698900985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1j98rZpvN2vq/fHUHmpIc9b4uE1v2coS0MSrmodl+rM=;
        b=uLlaE4eyS7zaaDFUoTqJGa/n/FSQW3NZOA8xUZQLS8JDewQqMjMgj1XUGrczbz2djJ
         VJysR7dfQJ4uicCO9YahhLVt8c3F7ss6SvRvFNeCg9tMkdLUd6FT57CNMV/F57Zj/6/M
         gWzx12fLac4X1PbzPixITLRbOeeO7rTQcq0Ob1G3ibrbGRM7WrTVQmzGRv4nF+UAIFim
         HVjMeWbgwGWwEE01m64DOXb1spvKvngeKXV/ecRKo7MWcQTy4+Ohs1Q5QrQoVSlJ4M0d
         SJ3RbCDLdssXggK75IzAIsJpf3D4ejqCug7HMVMCXe3wZcBG2sZtJHFA7T2Sj9C9F8+S
         57fw==
X-Gm-Message-State: AOJu0YzAS0mKR61YeL3+gZBG5UqvTVGsVW2bUrc4ZfNOmpbu5WMGdHJE
        8hJPmCdXiTuoZ3MztmMYfCUfBg5gFs1hVrBvGc4=
X-Google-Smtp-Source: AGHT+IF1Kce39ZHjR5JLBQ5tOvF3Q9ue3YOzFGr9CdkF62Kp/LXll3g/EhaWIjRy+SZeo2tPOICQjW5VQ2n8xmYxObA=
X-Received: by 2002:ad4:5f07:0:b0:658:997f:79b7 with SMTP id
 fo7-20020ad45f07000000b00658997f79b7mr22466993qvb.3.1698296185273; Wed, 25
 Oct 2023 21:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231023105915.29482-1-m.muzzammilashraf@gmail.com>
In-Reply-To: <20231023105915.29482-1-m.muzzammilashraf@gmail.com>
From:   Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Date:   Thu, 26 Oct 2023 09:56:14 +0500
Message-ID: <CAJHePoaNc6tJodB+vRM67Ac9NcAQ5x9gTC+g9P7-N3jWm5AfNA@mail.gmail.com>
Subject: Re: [PATCH] drivers: target: Fixed multiple typos in multiple files
To:     martin.petersen@oracle.com, bostroesser@gmail.com,
        michael.christie@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can anyone approve this patch?

On Mon, Oct 23, 2023 at 3:59=E2=80=AFPM Muhammad Muzammil
<m.muzzammilashraf@gmail.com> wrote:
>
> iscsi: iscsi_target.c: Fixed typo
> iscsi: iscsi_target_login.c: Fixed typo
> iscsi: iscsi_target_nego.c: Fixed typo
> iscsi: iscsi_target_parameters.h: Fixed typo
> iscsi: iscsi_target_tpg.c: Fixed typo
> target_core_sbc.c: Fixed typo
> target_core_transport.c: Fixed typo
> target_core_user.c: Fixed typo
> target_core_xcopy.h: Fixed typo
> tcm_fc: tfc_conf.c: Fixed typo
> tcm_fc: tfc_sess.c: Fixed typo
>
> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
> ---
>  drivers/target/iscsi/iscsi_target.c            | 2 +-
>  drivers/target/iscsi/iscsi_target_login.c      | 2 +-
>  drivers/target/iscsi/iscsi_target_nego.c       | 4 ++--
>  drivers/target/iscsi/iscsi_target_parameters.h | 2 +-
>  drivers/target/iscsi/iscsi_target_tpg.c        | 2 +-
>  drivers/target/target_core_sbc.c               | 2 +-
>  drivers/target/target_core_transport.c         | 4 ++--
>  drivers/target/target_core_user.c              | 4 ++--
>  drivers/target/target_core_xcopy.h             | 2 +-
>  drivers/target/tcm_fc/tfc_conf.c               | 2 +-
>  drivers/target/tcm_fc/tfc_sess.c               | 4 ++--
>  11 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/i=
scsi_target.c
> index 1d25e64b068a..b1d61f717b3d 100644
> --- a/drivers/target/iscsi/iscsi_target.c
> +++ b/drivers/target/iscsi/iscsi_target.c
> @@ -4591,7 +4591,7 @@ static void iscsit_logout_post_handler_closesession=
(
>         /*
>          * Traditional iscsi/tcp will invoke this logic from TX thread
>          * context during session logout, so clear tx_thread_active and
> -        * sleep if iscsit_close_connection() has not already occured.
> +        * sleep if iscsit_close_connection() has not already occurred.
>          *
>          * Since iser-target invokes this logic from it's own workqueue,
>          * always sleep waiting for RX/TX thread shutdown to complete
> diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/i=
scsi/iscsi_target_login.c
> index 90b870f234f0..761d2783c89c 100644
> --- a/drivers/target/iscsi/iscsi_target_login.c
> +++ b/drivers/target/iscsi/iscsi_target_login.c
> @@ -570,7 +570,7 @@ int iscsi_login_post_auth_non_zero_tsih(
>         /*
>          * By following item 5 in the login table,  if we have found
>          * an existing ISID and a valid/existing TSIH and an existing
> -        * CID we do connection reinstatement.  Currently we dont not
> +        * CID we do connection reinstatement.  Currently we don't not
>          * support it so we send back an non-zero status class to the
>          * initiator and release the new connection.
>          */
> diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/is=
csi/iscsi_target_nego.c
> index fa3fb5f4e6bc..ca24804e5386 100644
> --- a/drivers/target/iscsi/iscsi_target_nego.c
> +++ b/drivers/target/iscsi/iscsi_target_nego.c
> @@ -557,7 +557,7 @@ static void iscsi_target_do_login_rx(struct work_stru=
ct *work)
>          * before initial PDU processing in iscsi_target_start_negotiatio=
n()
>          * has completed, go ahead and retry until it's cleared.
>          *
> -        * Otherwise if the TCP connection drops while this is occuring,
> +        * Otherwise if the TCP connection drops while this is occurring,
>          * iscsi_target_start_negotiation() will detect the failure, call
>          * cancel_delayed_work_sync(&conn->login_work), and cleanup the
>          * remaining iscsi connection resources from iscsi_np process con=
text.
> @@ -1050,7 +1050,7 @@ static int iscsi_target_do_login(struct iscsit_conn=
 *conn, struct iscsi_login *l
>                                 /*
>                                  * Check to make sure the TCP connection =
has not
>                                  * dropped asynchronously while session r=
einstatement
> -                                * was occuring in this kthread context, =
before
> +                                * was occurring in this kthread context,=
 before
>                                  * transitioning to full feature phase op=
eration.
>                                  */
>                                 if (iscsi_target_sk_check_close(conn))
> diff --git a/drivers/target/iscsi/iscsi_target_parameters.h b/drivers/tar=
get/iscsi/iscsi_target_parameters.h
> index 00fbbebb8c75..c143d487afa8 100644
> --- a/drivers/target/iscsi/iscsi_target_parameters.h
> +++ b/drivers/target/iscsi/iscsi_target_parameters.h
> @@ -95,7 +95,7 @@ extern void iscsi_set_session_parameters(struct iscsi_s=
ess_ops *,
>  #define OFMARKINT                      "OFMarkInt"
>
>  /*
> - * Parameter names of iSCSI Extentions for RDMA (iSER).  See RFC-5046
> + * Parameter names of iSCSI Extensions for RDMA (iSER).  See RFC-5046
>   */
>  #define RDMAEXTENSIONS                 "RDMAExtensions"
>  #define INITIATORRECVDATASEGMENTLENGTH "InitiatorRecvDataSegmentLength"
> diff --git a/drivers/target/iscsi/iscsi_target_tpg.c b/drivers/target/isc=
si/iscsi_target_tpg.c
> index f7bac98fd4fe..23478c8957df 100644
> --- a/drivers/target/iscsi/iscsi_target_tpg.c
> +++ b/drivers/target/iscsi/iscsi_target_tpg.c
> @@ -313,7 +313,7 @@ int iscsit_tpg_enable_portal_group(struct iscsi_porta=
l_group *tpg)
>         }
>         /*
>          * Make sure that AuthMethod does not contain None as an option
> -        * unless explictly disabled.  Set the default to CHAP if authent=
ication
> +        * unless explicitly disabled.  Set the default to CHAP if authen=
tication
>          * is enforced (as per default), and remove the NONE option.
>          */
>         param =3D iscsi_find_param_from_key(AUTHMETHOD, tpg->param_list);
> diff --git a/drivers/target/target_core_sbc.c b/drivers/target/target_cor=
e_sbc.c
> index 6a02561cc20c..35dfe5cb40ec 100644
> --- a/drivers/target/target_core_sbc.c
> +++ b/drivers/target/target_core_sbc.c
> @@ -573,7 +573,7 @@ sbc_compare_and_write(struct se_cmd *cmd)
>         int rc;
>         /*
>          * Submit the READ first for COMPARE_AND_WRITE to perform the
> -        * comparision using SGLs at cmd->t_bidi_data_sg..
> +        * comparison using SGLs at cmd->t_bidi_data_sg..
>          */
>         rc =3D down_interruptible(&dev->caw_sem);
>         if (rc !=3D 0) {
> diff --git a/drivers/target/target_core_transport.c b/drivers/target/targ=
et_core_transport.c
> index c81def3c96df..665eb2d9bc19 100644
> --- a/drivers/target/target_core_transport.c
> +++ b/drivers/target/target_core_transport.c
> @@ -1820,7 +1820,7 @@ EXPORT_SYMBOL_GPL(target_submit_prep);
>   * This may only be called from process context, and also currently
>   * assumes internal allocation of fabric payload buffer by target-core.
>   *
> - * It also assumes interal target core SGL memory allocation.
> + * It also assumes internal target core SGL memory allocation.
>   *
>   * This function must only be used by drivers that do their own
>   * sync during shutdown and does not use target_stop_session. If there
> @@ -3447,7 +3447,7 @@ static const struct sense_detail sense_detail_table=
[] =3D {
>                  * REGISTER AND MOVE service actionis attempted,
>                  * but there are insufficient device server resources to =
complete the
>                  * operation, then the command shall be terminated with C=
HECK CONDITION
> -                * status, with the sense key set to ILLEGAL REQUEST,and =
the additonal
> +                * status, with the sense key set to ILLEGAL REQUEST,and =
the additional
>                  * sense code set to INSUFFICIENT REGISTRATION RESOURCES.
>                  */
>                 .key =3D ILLEGAL_REQUEST,
> diff --git a/drivers/target/target_core_user.c b/drivers/target/target_co=
re_user.c
> index 7eb94894bd68..d13e38fcee4c 100644
> --- a/drivers/target/target_core_user.c
> +++ b/drivers/target/target_core_user.c
> @@ -1985,7 +1985,7 @@ static int tcmu_release(struct uio_info *info, stru=
ct inode *inode)
>                 tcmu_free_cmd(cmd);
>         }
>         /*
> -        * We only freed data space, not ring space. Therefore we dont ca=
ll
> +        * We only freed data space, not ring space. Therefore we don't c=
all
>          * run_tmr_queue, but call run_qfull_queue if tmr_list is empty.
>          */
>         if (freed && list_empty(&udev->tmr_queue))
> @@ -3125,7 +3125,7 @@ static ssize_t tcmu_free_kept_buf_store(struct conf=
ig_item *item, const char *pa
>         tcmu_cmd_free_data(cmd, cmd->dbi_cnt);
>         tcmu_free_cmd(cmd);
>         /*
> -        * We only freed data space, not ring space. Therefore we dont ca=
ll
> +        * We only freed data space, not ring space. Therefore we don't c=
all
>          * run_tmr_queue, but call run_qfull_queue if tmr_list is empty.
>          */
>         if (list_empty(&udev->tmr_queue))
> diff --git a/drivers/target/target_core_xcopy.h b/drivers/target/target_c=
ore_xcopy.h
> index 0aad7dc65895..5337d4f89a8d 100644
> --- a/drivers/target/target_core_xcopy.h
> +++ b/drivers/target/target_core_xcopy.h
> @@ -42,7 +42,7 @@ struct xcopy_op {
>  };
>
>  /*
> - * Receive Copy Results Sevice Actions
> + * Receive Copy Results Service Actions
>   */
>  #define RCR_SA_COPY_STATUS             0x00
>  #define RCR_SA_RECEIVE_DATA            0x01
> diff --git a/drivers/target/tcm_fc/tfc_conf.c b/drivers/target/tcm_fc/tfc=
_conf.c
> index 5ee03d1cba2b..4b066e14f885 100644
> --- a/drivers/target/tcm_fc/tfc_conf.c
> +++ b/drivers/target/tcm_fc/tfc_conf.c
> @@ -281,7 +281,7 @@ static void ft_del_tpg(struct se_portal_group *se_tpg=
)
>
>         destroy_workqueue(tpg->workqueue);
>
> -       /* Wait for sessions to be freed thru RCU, for BUG_ON below */
> +       /* Wait for sessions to be freed through RCU, for BUG_ON below */
>         synchronize_rcu();
>
>         mutex_lock(&ft_lport_lock);
> diff --git a/drivers/target/tcm_fc/tfc_sess.c b/drivers/target/tcm_fc/tfc=
_sess.c
> index 593540da9346..e2ff506ca68d 100644
> --- a/drivers/target/tcm_fc/tfc_sess.c
> +++ b/drivers/target/tcm_fc/tfc_sess.c
> @@ -98,7 +98,7 @@ static void ft_tport_delete(struct ft_tport *tport)
>
>  /*
>   * Add local port.
> - * Called thru fc_lport_iterate().
> + * Called through fc_lport_iterate().
>   */
>  void ft_lport_add(struct fc_lport *lport, void *arg)
>  {
> @@ -110,7 +110,7 @@ void ft_lport_add(struct fc_lport *lport, void *arg)
>
>  /*
>   * Delete local port.
> - * Called thru fc_lport_iterate().
> + * Called through fc_lport_iterate().
>   */
>  void ft_lport_del(struct fc_lport *lport, void *arg)
>  {
> --
> 2.27.0
>
