Return-Path: <linux-kernel+bounces-9992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2ED81CE42
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EDDD1C217E2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876F82C190;
	Fri, 22 Dec 2023 18:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ImSJ7MpB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A18828DBD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bb69f38855so1470872b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 10:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703268302; x=1703873102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qPAPK3WSbdmkmN81o0yGwj/XQTt7KUa6hMNgOmDT1Mc=;
        b=ImSJ7MpBiXO3+67wqFBoHPBCPcFh4lJ6FDmsQh+ISmTtF+DAlL4Cbu+iU99f6sxBhA
         Ar1mg32ebGYOQAtiuJsWdFH6eMbDvr5Ryq8CF8KMRLSmdgdpyxAVkxGq2tgeHwcyD3PK
         m/VL6neIBuG8zcoUwcibVMoLlf524xXEfNXxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703268302; x=1703873102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPAPK3WSbdmkmN81o0yGwj/XQTt7KUa6hMNgOmDT1Mc=;
        b=DInqvwDc/B+lWofuD3x6EYrfX7scNKiWGfwg6vMhnZP7kf3HZ26F+mdOQbVn33UiOG
         s3qh9xYQk6q5ywmL4j7H+CLvH6qsfAA7b3lmX0iAoCwzISo2IIbd9jbUdvCHLav5I104
         vDo6uplISJks3YVSqBpuVEerFEbd7xCrALdsRrvoJqgZgILRIpH1RL+rhhb4bQ0CdaKk
         KWxHnhmeDOKMBqQng/09hc7M7hbsAiyxLkHpLvn3WlNklBUeEqW/FLjM4xSI43tojYG/
         /xCh+5c3Dxkn3BhLtVqauvlcN5ejsJtqev9PDMPjjo660N4JppOViZBy7vdCOy/3/pFy
         2BkQ==
X-Gm-Message-State: AOJu0Yw7LLVkcOw495ryMVLKT1zpHqTk2vNdIWBM3DlJ05+E8hjJImZD
	mukL9FO3PAXoIJe8z9MO33T4ceSvIfoXdM96IBAxUv3NS2oGvCIxXiz7EppMPhFDC2L3lVj8xm1
	GvwEEpUUk5O/lMBLyX/qidOnAqE1gi9NtFyo6dg==
X-Google-Smtp-Source: AGHT+IFjCYhVa/4/4mTZIA2rWK4VdBo1VmAcgQEfIDdQGr2/3zGRS47CeqGShh9Sc8mYT9ox0uCNxXDEtA+Pqz1zTls=
X-Received: by 2002:a05:6870:1810:b0:203:ca67:a5e2 with SMTP id
 t16-20020a056870181000b00203ca67a5e2mr1478617oaf.89.1703268301590; Fri, 22
 Dec 2023 10:05:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220162658.12392-1-dwagner@suse.de>
In-Reply-To: <20231220162658.12392-1-dwagner@suse.de>
From: Dick Kennedy <dick.kennedy@broadcom.com>
Date: Fri, 22 Dec 2023 10:04:50 -0800
Message-ID: <CAGx+d6cGuC8S2+_ipyKMtOxNQ5a0RW_H46jrwWJjwRx5TRw-ww@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: use unsigned type for num_sge
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001e715d060d1d0e8a"

--0000000000001e715d060d1d0e8a
Content-Type: multipart/alternative; boundary="00000000000012f1e1060d1d0e66"

--00000000000012f1e1060d1d0e66
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The change is good, however, I  don't think this was really the problem.

We would  like to know if this patch really solved an issue they observed.

 A good data point to know is what adapter they're using.
 If that adapter supports hybrid sgl (i.e. phba->cfg_xpsgl), then we
 would have set the max sg_tablesize =3D LPFC_MAX_SG_TABLESIZE =3D 0xffff.

 But even then, this patch implies that dma_map_sg() returned a crazy
 huge amount with the MSB set.

On Wed, Dec 20, 2023 at 8:29=E2=80=AFAM Daniel Wagner <dwagner@suse.de> wro=
te:

> From: Hannes Reinecke <hare@suse.de>
>
> LUNs going into =E2=80=9Cfailed ready running=E2=80=9D state observed on =
>1T and on
> even numbers of size (2T, 4T, 6T, 8T and 10T). The issue occurs when
> DIF is enabled at the host.
>
> The kernel logs:
>
>   Cannot setup S/G List for HBAIO segs 1/1 SGL 512 SCSI 256: 3 0
>
> The host lpfc driver is failing to setup scatter/gather list
> (protection data) for the IO's.
>
> The return type lpfc_bg_setup_sgl()/lpfc_bg_setup_sgl_prot() causes
> the compiler to remove the most significant bit. Use an unsigned type
> instead.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> [dwagner: added commit message]
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  drivers/scsi/lpfc/lpfc_scsi.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.=
c
> index d26941b131fd..bf879d81846b 100644
> --- a/drivers/scsi/lpfc/lpfc_scsi.c
> +++ b/drivers/scsi/lpfc/lpfc_scsi.c
> @@ -1918,7 +1918,7 @@ lpfc_bg_setup_bpl_prot(struct lpfc_hba *phba, struc=
t
> scsi_cmnd *sc,
>   *
>   * Returns the number of SGEs added to the SGL.
>   **/
> -static int
> +static uint32_t
>  lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
>                 struct sli4_sge *sgl, int datasegcnt,
>                 struct lpfc_io_buf *lpfc_cmd)
> @@ -1926,8 +1926,8 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct
> scsi_cmnd *sc,
>         struct scatterlist *sgde =3D NULL; /* s/g data entry */
>         struct sli4_sge_diseed *diseed =3D NULL;
>         dma_addr_t physaddr;
> -       int i =3D 0, num_sge =3D 0, status;
> -       uint32_t reftag;
> +       int i =3D 0, status;
> +       uint32_t reftag, num_sge =3D 0;
>         uint8_t txop, rxop;
>  #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
>         uint32_t rc;
> @@ -2099,7 +2099,7 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct
> scsi_cmnd *sc,
>   *
>   * Returns the number of SGEs added to the SGL.
>   **/
> -static int
> +static uint32_t
>  lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
>                 struct sli4_sge *sgl, int datacnt, int protcnt,
>                 struct lpfc_io_buf *lpfc_cmd)
> @@ -2123,8 +2123,8 @@ lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struc=
t
> scsi_cmnd *sc,
>         uint32_t rc;
>  #endif
>         uint32_t checking =3D 1;
> -       uint32_t dma_offset =3D 0;
> -       int num_sge =3D 0, j =3D 2;
> +       uint32_t dma_offset =3D 0, num_sge =3D 0;
> +       int j =3D 2;
>         struct sli4_hybrid_sgl *sgl_xtra =3D NULL;
>
>         sgpe =3D scsi_prot_sglist(sc);
> --
> 2.43.0
>
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

--00000000000012f1e1060d1d0e66
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The change is good, however, I=C2=A0 don&#39;t think this =
was really the problem.=C2=A0<div><br></div><div>We would=C2=A0 like to kno=
w if this patch really solved an issue they observed.<br><br>=C2=A0A good d=
ata point to know is what adapter they&#39;re using. <br>=C2=A0If that adap=
ter supports hybrid sgl (i.e. phba-&gt;cfg_xpsgl), then we<br>=C2=A0would h=
ave set the max sg_tablesize =3D LPFC_MAX_SG_TABLESIZE =3D 0xffff.<br><br>=
=C2=A0But even then, this patch implies that dma_map_sg() returned a crazy<=
br>=C2=A0huge amount with the MSB set.<br></div></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 20, 2023 at 8:2=
9=E2=80=AFAM Daniel Wagner &lt;<a href=3D"mailto:dwagner@suse.de" target=3D=
"_blank">dwagner@suse.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">From: Hannes Reinecke &lt;<a href=3D"mailto:hare@su=
se.de" target=3D"_blank">hare@suse.de</a>&gt;<br>
<br>
LUNs going into =E2=80=9Cfailed ready running=E2=80=9D state observed on &g=
t;1T and on<br>
even numbers of size (2T, 4T, 6T, 8T and 10T). The issue occurs when<br>
DIF is enabled at the host.<br>
<br>
The kernel logs:<br>
<br>
=C2=A0 Cannot setup S/G List for HBAIO segs 1/1 SGL 512 SCSI 256: 3 0<br>
<br>
The host lpfc driver is failing to setup scatter/gather list<br>
(protection data) for the IO&#39;s.<br>
<br>
The return type lpfc_bg_setup_sgl()/lpfc_bg_setup_sgl_prot() causes<br>
the compiler to remove the most significant bit. Use an unsigned type<br>
instead.<br>
<br>
Signed-off-by: Hannes Reinecke &lt;<a href=3D"mailto:hare@suse.de" target=
=3D"_blank">hare@suse.de</a>&gt;<br>
[dwagner: added commit message]<br>
Signed-off-by: Daniel Wagner &lt;<a href=3D"mailto:dwagner@suse.de" target=
=3D"_blank">dwagner@suse.de</a>&gt;<br>
---<br>
=C2=A0drivers/scsi/lpfc/lpfc_scsi.c | 12 ++++++------<br>
=C2=A01 file changed, 6 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c<=
br>
index d26941b131fd..bf879d81846b 100644<br>
--- a/drivers/scsi/lpfc/lpfc_scsi.c<br>
+++ b/drivers/scsi/lpfc/lpfc_scsi.c<br>
@@ -1918,7 +1918,7 @@ lpfc_bg_setup_bpl_prot(struct lpfc_hba *phba, struct =
scsi_cmnd *sc,<br>
=C2=A0 *<br>
=C2=A0 * Returns the number of SGEs added to the SGL.<br>
=C2=A0 **/<br>
-static int<br>
+static uint32_t<br>
=C2=A0lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sli4_sge *sg=
l, int datasegcnt,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lpfc_io_buf =
*lpfc_cmd)<br>
@@ -1926,8 +1926,8 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_=
cmnd *sc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct scatterlist *sgde =3D NULL; /* s/g data =
entry */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sli4_sge_diseed *diseed =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_addr_t physaddr;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int i =3D 0, num_sge =3D 0, status;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t reftag;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int i =3D 0, status;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t reftag, num_sge =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t txop, rxop;<br>
=C2=A0#ifdef CONFIG_SCSI_LPFC_DEBUG_FS<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t rc;<br>
@@ -2099,7 +2099,7 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_=
cmnd *sc,<br>
=C2=A0 *<br>
=C2=A0 * Returns the number of SGEs added to the SGL.<br>
=C2=A0 **/<br>
-static int<br>
+static uint32_t<br>
=C2=A0lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sli4_sge *sg=
l, int datacnt, int protcnt,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lpfc_io_buf =
*lpfc_cmd)<br>
@@ -2123,8 +2123,8 @@ lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct =
scsi_cmnd *sc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t rc;<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t checking =3D 1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t dma_offset =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int num_sge =3D 0, j =3D 2;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t dma_offset =3D 0, num_sge =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int j =3D 2;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sli4_hybrid_sgl *sgl_xtra =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sgpe =3D scsi_prot_sglist(sc);<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

<br>
<span style=3D"background-color:rgb(255,255,255)"><font size=3D"2">This ele=
ctronic communication and the information and any files transmitted with it=
, or attached to it, are confidential and are intended solely for the use o=
f the individual or entity to whom it is addressed and may contain informat=
ion that is confidential, legally privileged, protected by privacy laws, or=
 otherwise restricted from disclosure to anyone else. If you are not the in=
tended recipient or the person responsible for delivering the e-mail to the=
 intended recipient, you are hereby notified that any use, copying, distrib=
uting, dissemination, forwarding, printing, or copying of this e-mail is st=
rictly prohibited. If you received this e-mail in error, please return the =
e-mail to the sender, delete it from your computer, and destroy any printed=
 copy of it.</font></span>
--00000000000012f1e1060d1d0e66--

--0000000000001e715d060d1d0e8a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
KmQYmvvS69Yzni2ICLsrDnobRTQz+WU28a6Tom8jGCqdhb+M5vcQfd25irVB5mWTQSD/V0I4zzBC
RkPU8Z1cENcCpTGKiTIlxOcXqcGCfODOBp+b5t1LlI8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZZGljay5rZW5uZWR5QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUtdd4o7T03rmODooWDc+RholN
rvQwDQYJKoZIhvcNAQELBQADggEBAI7UnYAv1qdInCyVDoDFaQuWAbKCTIWSoBrfkGLmwnhlh/kD
6LUi0C5XGf1AtRHavNTJjv66Y7nieJzRwS2iu8UL+ymplb4DoW0zJLZsbS411vfBe/ce3jf1dKJz
+3Ae/9Rq2QXWZEn+8iryPGmX14yXMn8dNF031CdyjXiT2jLPdImXG8S85z0PJUWi8H3XZwkZG0Ob
Fy1OMqIo9Gb7bX6oTI2ynYefTa5tI3eT0Wdq/HbfJzwO0WmsvsilPyv5wmW8STXcM4MeqyDC34RR
R9PD82a4t2AfSBbyuvgQwwF6KMyuk4zR+dHIiVqmbgA7MFUsGl+5JEaheEErdWYuO0oxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxQn0c/D7RhpijTAm4w
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMQNuzz0cRc1Yp0xvNbDD2cSBKpzDbNw
X7kUrTLzSf6NMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIy
MjE4MDUwMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAWSKkJbCPi8oIjbaERTcxgbCi3UV7teY87DiL5Bk5O1x/XSk+s
BdHdvTZyUDksrgZ7nijrtovW3Rkk5WfZun2/y4nS8f5W1U840f6C6zQqoYhsi+yXmln/QGHuRzPO
nSxV0X6YaQLToZfE8P56fuGKoaM/4nCrDHv84kU6MjCYxlveWOo818hmevM18N0vKJBNAWFt0i2L
0AX+pDkP9Y7rLrSw7LQAh9g3ySIjVHSOam/gBJY7itXz4010tbLVN9ylwWAXSD1BmJKe1gW9hpwS
GIfJPKXRgGVGDWvF5RwdH3mu7qd7xM07GHjbs9qx9qQrOjNu+XT3fZjJnLQ9YjLo
--0000000000001e715d060d1d0e8a--

