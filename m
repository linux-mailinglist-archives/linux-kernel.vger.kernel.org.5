Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB497A48A6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241702AbjIRLnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241813AbjIRLmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:42:49 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF802FF;
        Mon, 18 Sep 2023 04:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1695037353;
        bh=jqS8JLnAplA7wzw9w6SIovBfK8W1tPXmfz+C/kfKmkw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=c+1628BDhEVW5L4JFN+JqKOqBHPi+bHKBC2PgAJCpr3kEHhNS4v8TDZbfcDxBo7K1
         PsHabXmh/J9zHKnzLWjnFQdHUkTkXHPxSFi/dpQULP9v/IylyJyLIg3P4OhB9Nc9Tw
         Fl71I+qznqTNamdOQuWEayuTAYxJ+fp+u7b1dd/Y=
Received: from [127.0.0.1] (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 35F36659AC;
        Mon, 18 Sep 2023 07:42:32 -0400 (EDT)
Message-ID: <3c3f9a2ee7f9effe7cf9d1077652e85de0eae66c.camel@xry111.site>
Subject: Re: [PATCHv3 pci-next 1/2] PCI/AER: correctable error message as
 KERN_INFO
From:   Xi Ruoyao <xry111@xry111.site>
To:     Grant Grundler <grundler@chromium.org>
Cc:     bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mahesh@linux.ibm.com, oohall@gmail.com,
        rajat.khandelwal@linux.intel.com, rajatja@chromium.org
Date:   Mon, 18 Sep 2023 19:42:30 +0800
In-Reply-To: <CANEJEGt-6+AGGSdZb9OTv3UrBn1fFFqk=A6TdYjBsq4SqTTxsA@mail.gmail.com>
References: <20230606035442.2886343-1-grundler@chromium.org>
         <4fa1e0fe-eec4-4e5c-8acd-274a039c048a@ixit.cz>
         <CANEJEGt-6+AGGSdZb9OTv3UrBn1fFFqk=A6TdYjBsq4SqTTxsA@mail.gmail.com>
Autocrypt: addr=xry111@xry111.site; prefer-encrypt=mutual;
 keydata=mDMEYnkdPhYJKwYBBAHaRw8BAQdAsY+HvJs3EVKpwIu2gN89cQT/pnrbQtlvd6Yfq7egugi0HlhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPoiTBBMWCgA7FiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQrKrSDhnnEOPHFgD8D9vUToTd1MF5bng9uPJq5y3DfpcxDp+LD3joA3U2TmwA/jZtN9xLH7CGDHeClKZK/ZYELotWfJsqRcthOIGjsdAPuDgEYnkdPhIKKwYBBAGXVQEFAQEHQG+HnNiPZseiBkzYBHwq/nN638o0NPwgYwH70wlKMZhRAwEIB4h4BBgWCgAgFiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwwACgkQrKrSDhnnEOPjXgD/euD64cxwqDIqckUaisT3VCst11RcnO5iRHm6meNIwj0BALLmWplyi7beKrOlqKfuZtCLbiAPywGfCNg8LOTt4iMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-08-14 at 08:40 -0700, Grant Grundler wrote:
> On Sat, Aug 12, 2023 at 5:45=E2=80=AFPM David Heidelberg <david@ixit.cz>
> wrote:
> >=20
> > Tested-by: David Heidelberg <david@ixit.cz>
>=20
> Thanks David!
>=20
> > For PATCH v4 please fix the typo reported by the bot :)
>=20
> Sorry - I'll do that today.

Hi Grant,

Is there an update of this series?

My workstation suffers from too much correctable AER reporting as well
(related to Intel's errata "RPL013: Incorrectly Formed PCIe Packets May
Generate Correctable Errors" and/or the motherboard design, I guess).

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
