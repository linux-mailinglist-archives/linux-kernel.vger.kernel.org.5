Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45FC7641FF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 00:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjGZWQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 18:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjGZWQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 18:16:55 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DD9270F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 15:16:53 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3144bf65ce9so283945f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 15:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1690409811; x=1691014611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fR9LP/4pydqhSdIt3eqloczvKSXVWKiG1eLokNjPlbU=;
        b=IW9B1AcCAKpJaqJLfqkX9EMlaLlFC5dxIhYDD178fmLXK8okzYvf6qMAlT6Jj/VnHX
         rvUQtOYMHHtM6k4/bg5/SdwDVF64FWrKBBgcB9qS2FFW/gBck9iDEqtuOtya/VOENMqj
         PBxoEGQ8e4IjU9g3XCe6U4VijEieQyrIcbzb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690409811; x=1691014611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fR9LP/4pydqhSdIt3eqloczvKSXVWKiG1eLokNjPlbU=;
        b=TMFLGwd3AJSuba14nUiqbQWFRyD+joQ/01Pt7Ip+Y8+Ay7hAwpBUnfCilYy1D19qLa
         J5a7VS7j0lXMJsHK7b0HalLQg6c7fsMh3p448Gm+tbpTRHcJlkBJy7n7mzWpmoyl49Rk
         vfyDPmDJXI6mhRzQZ7DxltE9C1Lct6kx9rTycPC7CwMDbqbovcl+ljD7eSXb2A3D73A4
         5AajkKI0EB3HYGPkFGGMuhWlpZnSiwePE8psnDyWrY8Yk9nSlvsvv76UvzVt8pydMrFB
         e0TKXGx2sXhoSUZEHrgIcfpztjo5WdjMk+575lBv/FixQitu1gVtEyWwyWLZ3QbjNq2B
         is/A==
X-Gm-Message-State: ABy/qLaMUn58QyQl5Bt+B9Ra8IA96+5WLCvG4SX5DlDhs+BMeLi+MiWt
        jQ96zyHQJITz3Y2onFi4dwxI2Fug3huXdnyLXthlE2IV9Zu0rLiA/x8CtsKkn55ruiwlaPSmppH
        pC1UdmLsWjEao+Cm67LgVC2Rn+HcWT6FEA/oJgjos37zo
X-Google-Smtp-Source: APBJJlFxeeLyu2j025hh1G52m1NBSgrowI+mgfBm+SpKWb6NIBBwyMaidvJFBN6z0zOjWbb5fHl/WtXXFAc6/o8YSFo=
X-Received: by 2002:a5d:4c4a:0:b0:317:5d83:b43b with SMTP id
 n10-20020a5d4c4a000000b003175d83b43bmr287960wrt.38.1690409811528; Wed, 26 Jul
 2023 15:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230726155342.51623-1-dg573847474@gmail.com>
In-Reply-To: <20230726155342.51623-1-dg573847474@gmail.com>
From:   Justin Tee <justin.tee@broadcom.com>
Date:   Wed, 26 Jul 2023 15:16:39 -0700
Message-ID: <CAAmqgVOZwYS_TintuQNrE0go_Mxwk3YFJZA41Yt2S2isD7JW_Q@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: Fix potential deadlock on &phba->hbalock
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000005e14c406016b3414"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000005e14c406016b3414
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chengfeng,

lpfc_cmpl_els_uvem is for the VMID feature that could only ever be
called on an SLI4 type HBA.
lpfc_sli_intr_handler can only ever be called on an SLI3 type HBA.

So, the deadlock being referred to can never happen.

Thanks,
Justin

On Wed, Jul 26, 2023 at 8:55=E2=80=AFAM Chengfeng Ye <dg573847474@gmail.com=
> wrote:
>
> As &phba->hbalock is acquired by hardirq such as lpfc_sli_intr_handler(),
> process context code acquiring the lock &phba->hbalock should disable
> irq, otherwise deadlock could happen if the irq preempt the execution
> while the lock is held in process context on the same CPU.
>
> Most lock acquicision site disables irq but inside the callback
> lpfc_cmpl_els_uvem() the lock is acquired without explicitly disable irq.
> The outside caller of this callback also seems not disable irq.
>
> [Deadlock Scenario]
> lpfc_cmpl_els_uvem()
>     -> spin_lock(&phba->hbalock)
>         <irq>
>         -> lpfc_sli_intr_handle()
>         -> spin_lock(&phba->hbalock); (deadlock here)
>
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock.
>
> The patch fix the potential deadlock by spin_lock_irqsave() just like
> other callsite.
>
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> ---
>  drivers/scsi/lpfc/lpfc_els.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
> index 2bad9954c355..9667b4937b3a 100644
> --- a/drivers/scsi/lpfc/lpfc_els.c
> +++ b/drivers/scsi/lpfc/lpfc_els.c
> @@ -12398,6 +12398,7 @@ lpfc_cmpl_els_uvem(struct lpfc_hba *phba, struct =
lpfc_iocbq *icmdiocb,
>         u32 ulp_word4 =3D get_job_word4(phba, rspiocb);
>         struct lpfc_dmabuf *dmabuf =3D icmdiocb->cmd_dmabuf;
>         struct lpfc_vmid *vmid;
> +       unsigned long flags;
>
>         vmid =3D vmid_context->vmp;
>         if (!ndlp || ndlp->nlp_state !=3D NLP_STE_UNMAPPED_NODE)
> @@ -12419,11 +12420,11 @@ lpfc_cmpl_els_uvem(struct lpfc_hba *phba, struc=
t lpfc_iocbq *icmdiocb,
>                                  ulp_status, ulp_word4);
>                 goto out;
>         }
> -       spin_lock(&phba->hbalock);
> +       spin_lock_irqsave(&phba->hbalock, flags);
>         /* Set IN USE flag */
>         vport->vmid_flag |=3D LPFC_VMID_IN_USE;
>         phba->pport->vmid_flag |=3D LPFC_VMID_IN_USE;
> -       spin_unlock(&phba->hbalock);
> +       spin_unlock_irqrestore(&phba->hbalock, flags);
>
>         if (vmid_context->instantiated) {
>                 write_lock(&vport->vmid_lock);
> --
> 2.17.1
>

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--0000000000005e14c406016b3414
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
QsyUohclvlxgt5d/MsBG6WZxZ+uppzNvjEk/wUu+6JQNUVEMviA6eBCCi+4ShjZUbGPES11h5lw/
wuyQZDIjy+1hGPtLHBXI/QQEbU3OVdTRn+aEMwIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdqdXN0aW4udGVlQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUlHfvnuNaLp52RO2Y2En9J+7MKI4wDQYJ
KoZIhvcNAQELBQADggEBAGaBsEmLZwejb3YsmigadLZGto3hJ7Erq2YZLhL7Pgtxft1/j4JNLsRN
t3ZJIW2Xzfbj0p328xRekSP1gjZ9Szre0fxEFXH1sS1a7WP9E0fHxVW07xVsxGxo5opAh5Gf/bQH
S4x9pCO48FJI310L1RGQiqFKY/OECnXO821y8MAyObbGo9HNHP4Sk6F5J1v2qJzbLtMfj8ybbTGe
SidstRgjOIqMldZs2Koio14QFE7hJY+8KRiKfq+eb1EwQTMzBxZsMOL5vUSZjYg2+Fqwyr6YYp0w
Lsq/wH9o18xSvL/FikpG4JRxiT20RdM6DQrk9lv8ijASZCuN3JR61WUNz2AxggJtMIICaQIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwMd6BsMSBDsagVFtYwDQYJYIZI
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFPbQmGFwppLa9tyevXzIGtX5zXdOmgnu7jURtfU
g3r7MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDcyNjIyMTY1
MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQAvhaS8EHDgdWsSIiao6inkoNN/DGRaG1bxX4vyo5oTsdgQE1wr4mvZqC7B
mM/RqF8MyQ1WbpY77hyPGSCybQIPAzscRn4e3tRpsYE3C6HfPZ1LsAuNULnuFXzG/Da096vU67z9
A0IkKrQVU8sN1ZMoICnaLrGHB5e7raJKnnRVqzxBepV1eE13/rqKMluJ1cryJc+D4NAy4XcWvHJe
qQGdjXcJkugHromFp/yuCJRE6Q9Qcl5COVKhyDhGgdH+nG61SR6+/yvlwce4cbx7+cvEytwtTgXl
GWV+BAA3mV+O4rvu/BAUc9RwlvwmS5NcVghKBarWtTOb/WMuHBnnEz0A
--0000000000005e14c406016b3414--
