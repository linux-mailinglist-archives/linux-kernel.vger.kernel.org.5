Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E7C77061E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjHDQhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjHDQhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:37:38 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF18170F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:37:36 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40a47e8e38dso310671cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691167055; x=1691771855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YTip6s7Loh3TOdN1yFeXhTIES4BpCWlKL7HeHYS4/E4=;
        b=3YpfqKRHnum/83XHfepMXHlWEUrgaJl2CQFZODv01ncw0wha2x2vgZTtq4sjRIH72u
         8V0Gucvrj8vGq7W4PJhg1dZBnx0TBPISMJUMImyNydgGUaGYNnDPOFT/kBz7nnWm6Z4l
         56+nFyl0TTd9k3hXHxQAfSftDvBkF2i02cTLm4zAjqJvVQntVLMAeJmtdi/nt86CefO9
         koN4JR6ZMw65YmvbZ5WuT+nr7mrxQTK87HGLlag8Vei8qGs4F0SCj48pMW46M7sHdV2X
         TLxK3juDIeG3frjL4FQaCfaRp9R4Bwi86OHitbaFNKTHq+8pWc8uMcKmJnCqG1C4lDDk
         5t4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691167055; x=1691771855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTip6s7Loh3TOdN1yFeXhTIES4BpCWlKL7HeHYS4/E4=;
        b=XrsJZblp121Mqmc2rJIGFVlUaeG3/GKM0rLJv9Wg/oqQb+pqtTJZRp/XDxoK3N7FYr
         zPOZYXD7zsT+FkcwZJxe0PgGS4HQWcDUtR3oFhTZbb53o5d/8biAlrjjgQyHwZXEOVg0
         G6MzmmVESuCd+rnGcn4ZaGzX0L/UyQ1iK94pAqLLf2udkzyLA8N5CrWLC+k3QIwlNMX1
         krTuRNE7X1DMmofVL6ZJX42fAzS3F8W05epi6WTleJw6BLrZABBF9meu48QnhEvJPa/R
         rMD6kIhlCOEK4Ypmao2zmEeA6uujuaiI9NwyWsOW4ijgw6jXmAxGgiCXcVlJEKjEog+v
         hKng==
X-Gm-Message-State: AOJu0YyIYaCDu5Z9O2JkIklO4Fdh/WZxpO5b+0Gvci/FdL62nWeu06EG
        hqkOyGapHLwIpT0AOSy7EFEZs+qzecRnwhpkZ+UjcA==
X-Google-Smtp-Source: AGHT+IFBYZGzWAQTPXplY5U/FlDzvzxWuptyu00swf4QfQ9XFIj+FlFYBzhKRzYMzY3WDqIW2nbJAOHId8SGyAgT8sc=
X-Received: by 2002:a05:622a:1449:b0:403:d35d:4660 with SMTP id
 v9-20020a05622a144900b00403d35d4660mr217786qtx.11.1691167054974; Fri, 04 Aug
 2023 09:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <169057265801.180586.10867293237672839356.stgit@dwillia2-xfh.jf.intel.com>
 <CAMkAt6ot9zyUL9Ub-qYq+d9v-6rTft4ea2mUxp3o1s3GVFq7nw@mail.gmail.com>
 <CUHEL5OD3UR8.FRBWNF6MTP1Y@suppilovahvero> <64cc650233ef9_782a329489@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <64cc650233ef9_782a329489@dwillia2-xfh.jf.intel.com.notmuch>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Fri, 4 Aug 2023 09:37:23 -0700
Message-ID: <CAAH4kHY_SjTdh55NBWn1KURCdjJUDM7nhi_gLpUhKKbRsVjX4Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] keys: Introduce tsm keys
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Gonda <pgonda@google.com>, dhowells@redhat.com,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>, peterz@infradead.org,
        linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In this model the kernel is only a conduit to get 64-bytes of data
> signed by the report, and the kernel need not have any requirements on
> that data. That said, it could. That's where I would look to
> recommendations from Dionna and James and others about what contract the
> kernel *could*  enforce to ensure that best security practices are being
> deployed.  I expect that also helps this implementation cross the
> threshold from "blob store" to "key" as the Keyring expects.
>

I believe there is no security best practice here yet to enforce.

Attestation reports are a power feature, just like a TPM. A TPM
doesn't place any restriction on the format for its nonce, and like
James said, there's already a special entry point for TPM-wrapped keys
in the key API. Users have access to TPM quotes through /dev/tpm0 and
can pass whatever nonce. I don't think we need to limit access to the
interface this hardware gives us because we're trying to avoid another
char device by saying a report is a key.

The coming addition of the SVSM to further isolate the guest and
provide extra "security devices" is also something to be aware of.
There will be a vTPM protocol and a new type of attestation that's
rooted to VMPL0 while Linux is still in VMPL3. I don't think this will
make sev-guest an unnecessary device though, since it's still
undecided how the TPM hierarchy can bind itself to the hardware in a
non-adhoc manner: there's no "attested TPM" spec to have something
between the null hierarchy and the more persistent attestation key
hierarchy. And TCG isn't in the business of specifying how to
virtualize the TPM technology, so we might have to manually link the
two together by getting the tpm quote and then doing a further binding
operation with the sev-guest device.

So, can we give unfettered access to the hardware through not a Key
API but an Attestation API, and for historical reasons allow vTPM to
be its own thing with extra commands? The SVSM could allow users to
have access to more commands than getting an attestation report, like
a virtual HSM separate from the TPM. We wouldn't be able to access it
without a SEV-SNP-specific device. Does that mean it can't be
upstreamed? Do all confidential computing technologies specifically
not differentiate themselves in their capabilities to all use the same
kernel API for interaction?

-- 
-Dionna Glaze, PhD (she/her)
