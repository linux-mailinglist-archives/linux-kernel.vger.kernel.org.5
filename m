Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D772C7CB6E3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbjJPXME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjJPXMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:12:02 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D13AB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:12:00 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so2727a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697497919; x=1698102719; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=INYfmMsWN7edn0Gii+wE0NftUpFkex0ev6KVgsT42SE=;
        b=jUVK6HZ4l5ETNvgBmZtncQIr8LuHKjwqSKgMa9/VDcnM60uur03jGYWIfs0ZA9mjCt
         eKjJB0pVgfgnFff5SadMLCLM5GblCOYHe+JY75lUot8BKoA+XckpOtFakAvYxPsbe24u
         Wo+hEV0ZbsgxxhQMSRrGQ+GgJ+eGvNhNXsyjOLbviy5VWQMtX3+DFxwnYBZ0QY18Pfkt
         0TZPmTu2BxQQ6r7trBOZRLv+ECookiqqp6GFIX/o2niiTGEzY5BtdAru0YQgRXgzBvNo
         vzLvuNIjkrnixjwRc8E4TdUFnGL/0Fr1k8+JdiGm2PoGTdtouoT9z8QwOwoPIzDU5giE
         jMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697497919; x=1698102719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INYfmMsWN7edn0Gii+wE0NftUpFkex0ev6KVgsT42SE=;
        b=VJ1aeOfGaCqD5RfWZzsGGVQBjb+zce6w4zrYz21PiIwh+JSaQ3UJ3t7wElb0hzUY4N
         BdEfhg06pNGrYGG35Qh2Puz42Sd5YRYiD5loCRf1jPcLXJ8kYW5g2vKrPJn4Nsw7Ns8J
         WAdozSSfe88dhP8T7kyu1H6NWs+D10LSAsJINb91scufqEpvO1snhE3KQXj4amtpoZqQ
         YevRXsfhO85j76lGiMVuOvveKuaH7NNLs9dJIgBd/P84fY+EFE6J948wgVhooEjljlxu
         /OcwmjhKuWTU3P2wmnqZgMTbmtEGNwL9QfVsNJt5AKQAMJrvGFJ0p9401m4Gpe9ISqJi
         AKfw==
X-Gm-Message-State: AOJu0YyjOLWZRf4GKxzorGFTHjee3oSY5pxStRJlzJ3ZinIM+5yy/MCV
        lWhn1InuBEV8u5oV34/zyjpQmsLFU/gf3U8MH16Qwg==
X-Google-Smtp-Source: AGHT+IG1cYwz5bu/5ZgBzdw9ECTZUbCA2/P7RKfZVDqe7dVEa7NHVFBLtd0yrRKFg2ZVXhodz1Qj9XcCQ0fTbqf323w=
X-Received: by 2002:a50:c31b:0:b0:538:5f9e:f0fc with SMTP id
 a27-20020a50c31b000000b005385f9ef0fcmr56602edb.0.1697497919196; Mon, 16 Oct
 2023 16:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231016132819.1002933-1-michael.roth@amd.com> <20231016132819.1002933-47-michael.roth@amd.com>
In-Reply-To: <20231016132819.1002933-47-michael.roth@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Mon, 16 Oct 2023 16:11:45 -0700
Message-ID: <CAAH4kHYiV5M+LK1Za02pC3u8hG8e2utybadxZPG94q12YsnSBw@mail.gmail.com>
Subject: Re: [PATCH v10 46/50] crypto: ccp: Add the SNP_{SET,GET}_EXT_CONFIG command
To:     Michael Roth <michael.roth@amd.com>
Cc:     kvm@vger.kernel.org, linux-coco@lists.linux.dev,
        linux-mm@kvack.org, linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        jroedel@suse.de, thomas.lendacky@amd.com, hpa@zytor.com,
        ardb@kernel.org, pbonzini@redhat.com, seanjc@google.com,
        vkuznets@redhat.com, jmattson@google.com, luto@kernel.org,
        dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com,
        peterz@infradead.org, srinivas.pandruvada@linux.intel.com,
        rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com,
        bp@alien8.de, vbabka@suse.cz, kirill@shutemov.name,
        ak@linux.intel.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com,
        jarkko@kernel.org, ashish.kalra@amd.com, nikunj.dadhania@amd.com,
        pankaj.gupta@amd.com, liam.merwick@oracle.com,
        zhi.a.wang@intel.com, Brijesh Singh <brijesh.singh@amd.com>,
        Alexey Kardashevskiy <aik@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/**
> + * struct sev_data_snp_ext_config - system wide configuration value for SNP.
> + *
> + * @config_address: address of the struct sev_user_data_snp_config or 0 when
> + *             reported_tcb does not need to be updated.
> + * @certs_address: address of extended guest request certificate chain or
> + *              0 when previous certificate should be removed on SNP_SET_EXT_CONFIG.
> + * @certs_len: length of the certs
> + */
> +struct sev_user_data_ext_snp_config {
> +       __u64 config_address;           /* In */
> +       __u64 certs_address;            /* In */
> +       __u32 certs_len;                /* In */
> +} __packed;
> +

Can we add a generation number to this? Whenever user space sets the
certs blob it will invalidate the instance-specific certificates that
are settable in KVM.
The VMM will need to weave the instance-specific data with the new
certs installed at the machine level since we're not adding
interpretation of the cert blob to KVM.


-- 
-Dionna Glaze, PhD (she/her)
