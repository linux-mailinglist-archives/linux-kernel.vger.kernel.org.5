Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7787DFBFC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 22:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjKBV2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 17:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKBV2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 17:28:04 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A5A187
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   subject:mime-version:content-transfer-encoding;
  bh=Z1NpHf+ickCZ3JZZnaLgy5uvJFGYSq4e+2hH9vxGT6o=;
  b=IHMb2YOCDY/Dv59PibWzdT7rnd/tiFfKfWS8YWCLriD7l9Y5xWoRpLUC
   r/KtHrOrr7Kdrfa3mignup/JCpmeEaMI4ppoaLscBml/CpoW1TYzzRXPb
   xwrSAB1hhcsh9M9M8drp/q6RryA1smqfYEtDxPsc8QYKEWz6XqFG2WT0p
   o=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=julia.lawall@inria.fr; spf=None smtp.helo=postmaster@zcs-store9.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  julia.lawall@inria.fr designates 128.93.142.36 as permitted
  sender) identity=mailfrom; client-ip=128.93.142.36;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="julia.lawall@inria.fr";
  x-sender="julia.lawall@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@zcs-store9.inria.fr) identity=helo;
  client-ip=128.93.142.36;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="julia.lawall@inria.fr";
  x-sender="postmaster@zcs-store9.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.03,272,1694728800"; 
   d="scan'208";a="134394949"
X-MGA-submission: =?us-ascii?q?MDEeuemg07ECtdgWwyBF/gXCatUf0rYEVG2UuN?=
 =?us-ascii?q?CMQzu8WX+yqMTLVDDYMsQipOJ8h8IkBPjzTs7OXOBRZ2e0dhDAtxC34L?=
 =?us-ascii?q?5EmbC4dC1LSlo7HgZLTxfzrEUT6x5t/GDDzk3DzsWq/D2DGrZXU1K3oG?=
 =?us-ascii?q?MnpCc/Zg1XYaJew9Ktk91WJQ=3D=3D?=
Received: from zcs-store9.inria.fr ([128.93.142.36])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Nov 2023 22:27:56 +0100
Date:   Thu, 2 Nov 2023 22:27:55 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Anton Eliasson <anton.eliasson@axis.com>
Cc:     nicolas palix <nicolas.palix@imag.fr>, cocci <cocci@inria.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel@axis.com
Message-ID: <978265928.4471013.1698960475973.JavaMail.zimbra@inria.fr>
In-Reply-To: <20231003-coccicheck-v1-1-07d2d900a52a@axis.com>
References: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com> <20231003-coccicheck-v1-1-07d2d900a52a@axis.com>
Subject: Re: [cocci] [PATCH 1/2] scripts: coccicheck: Return error from
 run_cmd_parmap
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [92.89.85.231]
X-Mailer: Zimbra 8.8.15_GA_4562 (ZimbraWebClient - FF119 (Linux)/8.8.15_GA_4570)
Thread-Topic: scripts: coccicheck: Return error from run_cmd_parmap
Thread-Index: /FuP+QpGx8nmd9ShkUiiXS4mQsbSqA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Mail original -----
> De: "Anton Eliasson" <anton.eliasson@axis.com>
> =C0: "Julia Lawall" <Julia.Lawall@inria.fr>, "nicolas palix" <nicolas.pal=
ix@imag.fr>
> Cc: "cocci" <cocci@inria.fr>, "linux-kernel" <linux-kernel@vger.kernel.or=
g>, "Anton Eliasson" <anton.eliasson@axis.com>,
> kernel@axis.com
> Envoy=E9: Mardi 3 Octobre 2023 16:25:14
> Objet: [cocci] [PATCH 1/2] scripts: coccicheck: Return error from run_cmd=
_parmap

> Exiting on error breaks the chain mode. Return the error instead in
> order for the caller to propagate it or in the case of chain, try the
> next mode.
>=20
> Signed-off-by: Anton Eliasson <anton.eliasson@axis.com>
> ---
> scripts/coccicheck | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index e52cb43fede6..95a312730e98 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -153,7 +153,7 @@ run_cmd_parmap() {
> =09err=3D$?
> =09if [[ $err -ne 0 ]]; then
> =09=09echo "coccicheck failed"
> -=09=09exit $err
> +=09=09return $err
> =09fi
> }
>=20

I tried disabling OCaml in my version of Coccinelle and then ran make cocci=
check with this patch.  But I didn't see any improvement.  On the other han=
d, it keeps going if I just remove the exit line entirely.  Is that what is=
 wanted?  One can still see the coccicheck failed message.

julia

> --
> 2.30.2
