Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23F67DF9BD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbjKBSPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjKBSPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:15:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFB9D59
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698948852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NW+YV2uLwTdlD8Qd7addq0svLC3cgDkrnxIxuA+hovU=;
        b=Z3igaz51W4UUAGHm2rCouIerhGkLFhR5RyB2N+cPPMmzc6u1Ns7M9fLU5fgAM7lS2Ucb2K
        92Vm7bv33Nd16vFFivgEvSRLX85/2VxBsQWEPyJQo02y/qVeBFlo4rt6bJmoLn8o7wIO6H
        xIjeYDW1sSWHUAg2Pr11jqwx4IUG8F0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-9nQYltE_Mlq3EDDtFdc6Yg-1; Thu, 02 Nov 2023 14:14:09 -0400
X-MC-Unique: 9nQYltE_Mlq3EDDtFdc6Yg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32da7983d20so833050f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 11:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698948848; x=1699553648;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NW+YV2uLwTdlD8Qd7addq0svLC3cgDkrnxIxuA+hovU=;
        b=TpckCC9dG2BCfTFYIPrz5KCAPPPwx/N2by4hKOBRiRbx9aNcza4X4/dVNeruq6aCur
         zpEl81qd/H1fjhs+GFFKawPVzBDP9LuJ8Ln1OaDjqbJf+eTSVKFOK6lxH6xMfyOnmbkz
         Vyl9+b/+hoi0/H5Hx4VzaIJ0PIkKs8FnTBIl+2jfeeUfELqHtR+uGTw1YBzvdgfyugsU
         BkahxZ0COdBVjRLaj7+oFFDkwJoLlZh7bYDcBRHYtOKCFInboRb7U8acsyvOrqSdgM5p
         UPXrLVAvUJSjmRB8RHOooIpURAjPvZfVtUz3yQOsCejbl6R9rWFWUugKmwS4V0N0z0j6
         j4uA==
X-Gm-Message-State: AOJu0Yx3ot0yCaEJKdg4BQ5AWNBtzE5qiFRuaoCl8GDRgGlqrEZhTliM
        DwnSN+rJiJrIHRttr+N8CtGmnOa/PFBy18pWdkd180Uw73pO4gQ0xFx9Lwu/mdpfX2j3B+//UYV
        fYEJK8R3bjqGdJvugNlNTZsQu
X-Received: by 2002:a5d:6da7:0:b0:32f:75d2:bdba with SMTP id u7-20020a5d6da7000000b0032f75d2bdbamr368700wrs.6.1698948848135;
        Thu, 02 Nov 2023 11:14:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+ExAndHJW2+ysfQ5FsuJ1jlBFBD9QgwVTOw01ckExwh5O38L4OPFzkA+0+pe3DfMzRCU58w==
X-Received: by 2002:a5d:6da7:0:b0:32f:75d2:bdba with SMTP id u7-20020a5d6da7000000b0032f75d2bdbamr368673wrs.6.1698948847836;
        Thu, 02 Nov 2023 11:14:07 -0700 (PDT)
Received: from starship ([89.237.99.95])
        by smtp.gmail.com with ESMTPSA id u9-20020adfed49000000b00326b8a0e817sm3047099wro.84.2023.11.02.11.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:14:07 -0700 (PDT)
Message-ID: <015ee02a072460b9e844278f5cc4c3b3618f5e9e.camel@redhat.com>
Subject: Re: [PATCH 7/9] x86/sev-es: Include XSS value in GHCB CPUID request
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Borislav Petkov <bp@alien8.de>, John Allen <john.allen@amd.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, weijiang.yang@intel.com,
        rick.p.edgecombe@intel.com, seanjc@google.com, x86@kernel.org,
        thomas.lendacky@amd.com
Date:   Thu, 02 Nov 2023 20:14:05 +0200
In-Reply-To: <20231017184932.GBZS7XPESSMgPoCysY@fat_crate.local>
References: <20231010200220.897953-1-john.allen@amd.com>
         <20231010200220.897953-8-john.allen@amd.com>
         <20231012125924.GFZSftrGx43ALVCtfS@fat_crate.local>
         <ZS7OjlhJKI2xlbY/@johallen-workstation>
         <20231017184932.GBZS7XPESSMgPoCysY@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-17 at 20:49 +0200, Borislav Petkov wrote:
> On Tue, Oct 17, 2023 at 01:12:30PM -0500, John Allen wrote:
> > I looked into using __rdmsr in an earlier revision of the patch, but
> > found that it causes a build warning:
> > 
> > ld: warning: orphan section `__ex_table' from `arch/x86/boot/compressed/sev.o' being placed in section `__ex_table'
> > 
> > This is due to the __ex_table section not being used during
> > decompression boot. Do you know of a way around this?
> 
> Yeah, arch/x86/boot/msr.h.
> 
> We did those a while ago. I guess they could be moved to
> asm/shared/msr.h and renamed to something that is not a
> "boot_" prefix.
> 
> Something like
> 
> rdmsr_without_any_exception_handling_and_other_gunk_don_t_you_even_think_of_adding()
> 
> ...
> 
> But srsly:
> 
> raw_rdmsr()
> raw_wrmsr()
> 
> should be good, as tglx suggests offlist.
> 
> You can do that in one patch and prepend your set with it.
> 
> Thx.
> 


Assuming that we will actually allow the guest to read the IA32_XSS, then it is correct,
but otherwise we will need to return some cached value of IA32_XSS,
the same as the guest wrote last time.

Or another option: KVM can cache the last value that the guest wrote to IA32_XSS (I assume that
the guest can write msrs by sharing the address and value via GHCB), and then use it
when it constructs the CPUID.

Best regards,
	Maxim Levitsky



