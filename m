Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAF476A067
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjGaS2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjGaS22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:28:28 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5571BE6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:28:22 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f14865fcc0so583e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690828099; x=1691432899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cvfVGN64Yz22QUMEBnQLTws3rVwIXcDs5eogAVL6yuM=;
        b=z1d5+UX7XYBLc5qbQyuMw7rWEEKuv2TQFDcTMCZ6OV4JkvucedodvmaabpBkiF44d0
         m/K4p72gyDMp/ymng1FfGjNxxLqdWr4rM+5kOb/xEGRcsc6O5kRrOZ0x99PgeXO5tsrZ
         mXMxNykbv1E4JGmc/iCdFFGCyPi409p4eQVstzRXuL8rBbavGJhkyByuZKOrEDqUQj2L
         eIs1MA1ciAq5BQmFXw9kX/VhN1rYNqGyThqGPy3TXg+9zdJaEH+MY+v5p9dtCnhVa8HK
         SZA2IKzTZ/IA5Ra7Mv9sOeSFLfxzaThxsISmQUv8TDtkYA1VQxtPj9lStP5WTEOk/laO
         sQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690828099; x=1691432899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cvfVGN64Yz22QUMEBnQLTws3rVwIXcDs5eogAVL6yuM=;
        b=bjzNhTJ45YUIBcx3X2B+nlCBuofxSDbb/CTMgBPDgltzexQYD0A8ndOPJMqiE1lCb2
         Xd01Ugm+C75qx1XRo8es/5F8swUN55EsxcwUeMWemz8AjCheZHjaxMicQgnfwSbeIWj4
         o0Ms7fCOtdb/zS1fD9+RpoiO/wDkPHWGG/jMZSkOgm/NuB87opF15SLLB9Vh+JDFf86v
         Uqyoera1folvdfMqiqiTf+TNm6aoSRKmo1p5N1PlBm4oJq+GSJdYABUHDL3Au7tA1o8F
         h6/sRRLeco9gbPwulof7Do/ntMQbg3LpXpJzzrSyW9nHhzcnjvlLV59b8zXT8T5GJXF0
         dtCA==
X-Gm-Message-State: ABy/qLY+3CltJ8gMTVXIfs3WuLX+nQo/LID/Lr4sJIqegUyl+ZuDJDvD
        8MFgyre2p9YZPOz9zZJjg2lqrMH5d6r1o1MIuso/fg==
X-Google-Smtp-Source: APBJJlGXOlSonsATZcgcpwFmcM1bdURp+WkSA0XT9NFQlazdeHmtW8WNMTeMww29uH2H2bA9q7rX/l1S5/AL6zE3Ugo=
X-Received: by 2002:a19:f010:0:b0:4fd:eb37:7983 with SMTP id
 p16-20020a19f010000000b004fdeb377983mr119542lfc.1.1690828099374; Mon, 31 Jul
 2023 11:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <169057267580.180586.15710177655506555147.stgit@dwillia2-xfh.jf.intel.com>
 <CAMkAt6r=r_utT6sd_LD-2rO-GpH4zd1D04p04P8WF51BKX-JMg@mail.gmail.com> <64c7f7ddd777c_51ad029436@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <64c7f7ddd777c_51ad029436@dwillia2-xfh.jf.intel.com.notmuch>
From:   Peter Gonda <pgonda@google.com>
Date:   Mon, 31 Jul 2023 12:28:07 -0600
Message-ID: <CAMkAt6rotv3UtPifmsRK6wQ-Gh0LjZTnkzK-Gce0SdRz-iN+gg@mail.gmail.com>
Subject: Re: [PATCH 4/4] virt: sevguest: Add TSM key support for SNP_{GET, GET_EXT}_REPORT
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     dhowells@redhat.com, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>, peterz@infradead.org,
        linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > >
> > > +static int sev_auth_new(struct tsm_key_payload *t, void *provider_data)
> > > +{
> > > +       struct snp_guest_dev *snp_dev = provider_data;
> > > +       const int report_size = SZ_16K;
> > > +       const int ext_size =
> > > +               PAGE_ALIGN_DOWN(TSM_DATA_MAX - report_size - sizeof(*t));
> > > +       int ret;
> > > +
> > > +       if (t->pubkey_len != 64)
> > > +               return -EINVAL;
> >
> > Magic number?
> >
> > We only support asymmetric keys with public keys exactly equal to 64
> > bytes? Is that only p256? SNP uses p384 can we atleast allow that
> > curve too? But why not let userspace what key type they want to use?
>
> The kernel has no control here. See Table 20 MSG_REPORT_REQ Message
> Structure (https://www.amd.com/system/files/TechDocs/56860.pdf)
>
> ...only 64-byte payloads are accepted. I assume one could specify less
> than 64-bytes and zero-fill the rest, but that's a contract between the
> requester and the attester.

Great, we can then name this const.

Yes that's why typically the public key, any context, and nonce would
be hashed. Then we can include the digest into the report.

>
> >
> > > +
> > > +       if (t->auth_blob_format[0] &&
> > > +           strcmp(t->auth_blob_format, "extended") != 0)
> > > +               return -EINVAL;
> > > +
> > > +       if (t->auth_blob_format[0]) {
> > > +               u8 *buf __free(kvfree) =
> > > +                       kvzalloc(report_size + ext_size, GFP_KERNEL);
> > > +
> > > +               struct snp_ext_report_req req = {
> > > +                       .data = { .vmpl = t->privlevel },
> > > +                       .certs_address = (__u64)buf + report_size,
> > > +                       .certs_len = ext_size,
> > > +               };
> > > +               memcpy(&req.data.user_data, t->pubkey, 64);
> >
> > Again without any freshness from the remote party, of what use is this
> > attestation report?
>
> This interface is just marshaling the same data that could be retrieved
> via SNP_GET_REPORT ioctl on the sevguest chardev today. So I would point
> you back to vendor documentation for how this report is used. See "VM
> Launch and Attestation" here:
>
> https://www.amd.com/system/files/TechDocs/SEV-SNP-strengthening-vm-isolation-with-integrity-protection-and-more.pdf
>
> I am just here to stanch the proliferation of new chardevs and new
> ioctls for this TSM-common operation. This effort was started when TDX
> patches showed up to take a 64-byte input payload and wrap it in a
> attestation report with its own chardev and ioctls.

The way this is currently setup suggests that a user should add a
pubkey with the 'keyctl add tsm ...'. But if a user does this as
described here it won't allow them to set up a secure protocol with a
remote entity.

I think a user could abuse the naming of this system to do the correct
thing by using 'keyctl add tsm ..' over data which is not a public key
and is instead a digest of some public key with additional protocol
data.
