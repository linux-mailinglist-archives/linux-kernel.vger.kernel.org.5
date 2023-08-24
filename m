Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D187870CD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241494AbjHXNqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241581AbjHXNqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:46:22 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A2319B5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 06:46:16 -0700 (PDT)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6D5963F189
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1692884774;
        bh=dR8KuPjBVBHRPBoOloKZTURPWbFsOk06iuJLFNPyLAI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=qwKIYB7OqAYohdK2QxUhurmw9fAGhN/4ESqEIoCvr8GL6TDoegCjPDvrjH/uUzBjn
         xViqNKuySqEhZvFgA2yUQT1KRfAZbxKUawZuNxt/RDBBySJMqXBxM3za15twwo9drf
         nTxeGgBg/rg2getbyo8SoTyoSPLLYUrRXqFkpdSY/IkLBpy0Q0S3LbQiH35vToxp3A
         P1wkI0O5nTRH/ueIYDniyiiivdtEfw1IZEnG7rMvRM+95JEbG4WIgQOxFdqWPziMcs
         pD1r8nwCduPyPCcUW7aSRrnprAGEo86/hnijDzP3EzlDllEuPx/ZiD8Nk6uHWTmw0p
         a4Q4OgMlUoeYg==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26f3fce5b0bso5340799a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 06:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692884773; x=1693489573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dR8KuPjBVBHRPBoOloKZTURPWbFsOk06iuJLFNPyLAI=;
        b=btjwghuv9hgF49APqhwoaHCq6eN6BQnwvIOpaTWqe7wA/GafxQPjSegQTlWGp4ln87
         2v0rq9PHbgPeB9dPXrl6QojzPgQGZf/6PeUnqizijlpiBEOc7/3RM++Tm0Zx/rvghJB9
         cQoWv6aoBq52rWHIK2GqwGiprH7RdUHjgr5NSieB/KYQnkMygSZiClvnlMsEF4Y/Fb7w
         flT7qsXL0R2GiuRZWx6rprVE7O/yimK0/Y47mmpm33jWcPG4LcHZR+rA5z2QwGtLF9cU
         cPd5bLMmYA1GhObihQrknM3QSqglhPWupdmlVhbhRme0wjcj0CScKtspYqkWDJjLxhXI
         q/IA==
X-Gm-Message-State: AOJu0YzPn/OEagqsyIr6B220bTgXIfajBqM5CTQXtfWs/gqwGUWlOicf
        u6s13bNUjvx7nEEPUY+Ci0x7Q+N3af/r+3jCsyYjEzho7rB/+tL4SERbiwLwegLiItGmP1Uegow
        JOAEYT6fy/OGZer46HftwOT9BOmIFH/Do0j1HZicR6RlgPyyMIlrGthpirw==
X-Received: by 2002:a17:90b:2291:b0:26d:355a:47e3 with SMTP id kx17-20020a17090b229100b0026d355a47e3mr12312291pjb.38.1692884773143;
        Thu, 24 Aug 2023 06:46:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMKCG7MrQMN81qZGwsmCly0BZmn2ZLChrGLmXFOTD9lMITl2qaw7Oq3MrvHikI+Hm9TNTE3GUH9k+aV2wtj/o=
X-Received: by 2002:a17:90b:2291:b0:26d:355a:47e3 with SMTP id
 kx17-20020a17090b229100b0026d355a47e3mr12312279pjb.38.1692884772828; Thu, 24
 Aug 2023 06:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230824044645.423378-1-kai.heng.feng@canonical.com> <20230824115656.GW3465@black.fi.intel.com>
In-Reply-To: <20230824115656.GW3465@black.fi.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 24 Aug 2023 21:46:00 +0800
Message-ID: <CAAd53p4Ey15SRkeW-5rDQfxrT8Cif+hYOk2BZ6iQpfd8s51wEw@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: Add helper to check if any of ancestor device
 support D3cold
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     bhelgaas@google.com, koba.ko@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 24, 2023 at 7:57=E2=80=AFPM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Thu, Aug 24, 2023 at 12:46:43PM +0800, Kai-Heng Feng wrote:
> > In addition to nearest upstream bridge, driver may want to know if the
> > entire hierarchy can be powered off to perform different action.
> >
> > So walk higher up the hierarchy to find out if any device has valid
> > _PR3.
>
> I'm not entirely sure this is good idea. The drivers should expect that
> the power will be turned off pretty soon after device enters D3hot. Also
> _PR3 is not PCI concept it's ACPI concept so API like this would only
> work on systems with ACPI.

IIUC, Bjorn wants to limit the AER/DPC disablement when device power
is really off.
Is "the power will be turned off pretty soon after device enters
D3hot" applicable to most devices? Since config space is still
accessible when device is in D3hot.
Unless there are cases when device firmware behave differently to
D3hot? Then maybe it's better to disable AER for both D3hot, D3cold
and system S3.

Kai-Heng
