Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9307877D0B4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238677AbjHORPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbjHORPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:15:22 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF1E19B4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1692119719; bh=BPaGmpDTCMPb4Lvs/vaf+VcM/6CX3YE+Dt+y1F5XlrE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=uOcULKb3MvVxn1CqbvJlutVzek2dAWZhViTfAYlJYqw+dvKBlzy1h/mH3Au1Q8JkJ4b/tAZlYJYP4SmbBiJbrTfSCoTIQGAf7n85Nsl0zB2qRBCg6ukX+OWpN1JyrplQ7QvFseF528Lc0I4RwSaIgONgaeTOWmvMF/hjlBNbhxIb7XlTGnTmOhJ4xih8nBa9xo5Cy7Dn1UVZJOt4fhrZkkuRd/agp2HwjiI4yI4t870bW4NN97G0xeXaNpDgzfAKwfXt3llrCsKXDvrEn0yDmKIxNiEN8I1kxz3+IFXFoVTn+q3QDqfNW4myojEfLOnTgC1QYabY0MHUH4iD9/L0cQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1692119719; bh=cQax5ibei7TzbCpwrTjyZfxqsQ1/ouo1gSVL9s94JrD=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=rUgrLb9kX/CTc2sNWCynK5TVfosZPTwqtoEMmzLonbvKNnboejopWxbxhkze5O+gKLlIAiIRlk6XgnJMD5hmMQAHNVvKPbd/8g1I8PVhHQmvE0uTZb2Dx7YOSLn4+82FAsrhiUzOQdtqhggCw0wc34TAdvz862aI1h0D9SB68CzgUS4CX/HT70y7yeoWDnE1r19F3DKj2dxH8FVPtvexFQJE2XBWnuaEtZRiEh/1/MVIjAsD2zwwDrvx7rdy3xw2TNHRs+RGVovW2zhBFNXI7mUzcnnn5f08h8AsF1muZHZW/HaFkfNRZcNZLPGfet+lhGVfv4+CUZRlmbdrUNHJCQ==
X-YMail-OSG: 8LS1I7IVM1luXAHtx__GZ_0Q3g.xJp_Hg2ZMvaqkvbGmTAnq2RY0pvRlUIhtvPF
 prEzwpdHTUIwtxKRQjfTgl52GtTS.uut6uV2X7iAaBWE.aJSQcE86L8U9ELef_.EyyO0bR40VjzG
 l1f5royGcgeg7RNjRFQ4r9aYKo3KTWBwG5S3EVxsfG9G1sMK2A.Rx92griNnEwpOLZ_KV9sl6qhq
 4InkB6yAEiuIYLmQ5s9uZOc4au93QL9qgeZDM1D.XNP2TbNA31EGN81Dhx.o2Q1tupCjBhoDgZD1
 FoWQIoZPcBhYm7G_sRBxVfOL9EKL3rPfM4TwluBHwLi5kud1luGtKITmi5zBvlI_StTFfgruAh3D
 hST9Pb7q0KjDE5EuJOS5pDBgU0lWT9LqcQQgbCR6az2PgRUlt3KqcHyf9xqCpvNsR6r0enisIeSw
 arT8GHJv6oG1asoaEB4H1fWhTZ5oFlb8Z3eGP.E_ukJ2HBnuygYjCynts2U4Pp28bS_hHKDOIkCS
 2h_NV72TBCrquJqtYREuJbRcKEtC0iIdNHE_LyvdU7lRrxtOyuXWWlK8D0UwhHwhguZVQ9kZc.he
 5ETKii.llAkYFnL4mfPdJCmUTJdpsv_ePQQBPkUr7u.WaR8ZNc467KI.sJH4v5pdK8ng.G5YAPSY
 bS45obUV7BB4oVN_btipGmoMaGyBe4aXyaptDQgaoeYAIM2oh2N_a8t5.19i8qqoyAGJfeiesepw
 MBVs2vi6b.SsDoKjy2QCl2t7tcDL7zIUJcp1jymc3YKWewd6K9k3JWnuVyGzDFmKmwZJLnMzE0vA
 D7SNklo0jrgE.NO7HwdL_9jLNn0BEyUdJpRr.Y.WMm9yWveaMs9V89HtOAMkzZuXpa9pLzZpuVkA
 chj5m45GNeN6Cvq2M4hR3bJlRq4fvS3dK8tJoXNoRvEki6KExJGqYAn597x4Mk5kbK_fB5D1y_kM
 sPr6Y157JLXSZiUGkbvhKJAo8xyIsF5Mv0r75bic1pLT8UtCdsX1J4.KMRIGbmSZBADu7Fjnm6N.
 H_U4T5lV1fBv4uwqxAbjp_lQjwMaM2.S6z49q_DBJgEpKmG21cy2thsokRfNyKRhONxl21aFJOSo
 kIfu5eARbqaUEHDucUwwlSuMVkKC6pdqrbY0VYA2OkO61fCk0Y1a9RumhnbX_l.R8HTBfM__MuEj
 CxRRvTxHbVAIKlMLDO8vB9Reg669I72B0VSizy82WtDT8D4KKkXGIacE4e3BPZl1_7fOAvacPgao
 omd3MX18yU637wbCQR6Q3fFV5ounu.AKSHfZVRtCHuMdsV5UyoUR8nYw.IKi58feExsqykreKAK4
 LhRyUFtllDwgoyV6LVFtcHcI5uodME10BTicVZsDFqbNq2SnwZPc2IpSJuRhhmBZcGC7ZS_YKh6d
 a4dMNozB1c351kqcP9GSHEkkxBVxnIlh_MzInAYR5ct4m2NFzkzdMUYcKSHQj8YwFmgkulAmnVmq
 qPMBUOSOG8FzOSmlBMpwUZjshFujkGZN765CDK8m_tLAR8p_pKOZJldhOBCN_lF13_LIDyhHjdw3
 zwAaC6F91EJgTOSBgJdkNJ.T5AN9fJc5_eTC8gb93z3q.ylwmBTm2oA8IEixxphpHJEJ5_PCtbEp
 Y22lCEdNpKYit86.mV.Kun62NkqMLuWXtJFpwEfxulrfttZa6hFv2fa.9C0jJrFAMBBLu0WQHdU3
 HT0Nv_vDEafnbVmPKLua0DM9SJCL8BHZRSA.j5S0TO1zGLDOeMbEyGONwp3JMDTKJbXlxZmetF7r
 F0VPlALKm.FEDsTIOHi0utKzXwCqFczJdjvOz6wiV23ztdPrDpCjTRVA0ocMVvAwKACuEatM18HI
 P0gHKxB.nvOZXIcp3ITvvSzJfz6Rnl_weAIjoyAk4kkvrND_iLMItvwepuZ4qvzfyyzLXMEYUx_9
 CsHw_PsMRVHeD95ky2jwpFUKR5dZlJqC1M79ZhZQ9D7mc_x7HarXs356oQrqnUK5jatk4T1k0PMn
 q9hdn.qZCIAKpvPO.gV4qGz.yjAJjSekze_hbwNYKiuZMzc3tEWuDzcGYSllYn.X5K1cBMksR_No
 7H6ZySW2PLBgHEVpZAXoZRqG3R1f7avgV9c8heSCGj_yyv9SAjLc9QJ8mzR.AkD.A3tgIDCpWRQE
 vWgRkrp7Q4G90WoQE_dfzRRYHL0B40inWQwmWSKOkiu.ZFn46D8I5nibFDH3PI_OaLymVb5bs6E1
 734qk4UNbSnZusm88okWN._uFAeoC4Ftm9isEuj3zIOfqYe725d27EhY9cDmMBujgXL2FF_UK
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f868ec95-1348-40e1-b2ea-dd30d63b5a36
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 15 Aug 2023 17:15:19 +0000
Received: by hermes--production-bf1-865889d799-x5klk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4b4d581fd4f018528726dfdcaed7ce40;
          Tue, 15 Aug 2023 17:15:17 +0000 (UTC)
Message-ID: <04063c9b-3832-3934-7e4e-3bd969f19a1e@schaufler-ca.com>
Date:   Tue, 15 Aug 2023 10:15:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 03/13] Implement CAP_TRUST capability.
Content-Language: en-US
To:     "Dr. Greg" <greg@enjellic.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230710102319.19716-1-greg@enjellic.com>
 <20230710102319.19716-4-greg@enjellic.com>
 <c5b07b78-f37e-6e95-9c2e-044afe1dd894@schaufler-ca.com>
 <20230815101947.GA31391@wind.enjellic.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230815101947.GA31391@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21695 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/2023 3:19 AM, Dr. Greg wrote:
> On Mon, Aug 07, 2023 at 01:21:35PM -0700, Casey Schaufler wrote:
>
> Good morning, I hope this note finds the day starting well for
> everyone.
>
>> On 7/10/2023 3:23 AM, Dr. Greg wrote:
>>> TSEM was designed to support a Trust Orchestration System (TOS)
>>> security architecture.  A TOS based system uses the concept of a
>>> minimum Trusted Computing Base of utilities, referred to as trust
>>> orchestrators, that maintain workloads in a trusted execution
>>> state.  The trust orchestrators are thus, from a security
>>> perspective, the most security privileged processes running on
>>> the platform.
>>>
>>> The CAP_ML (machine modeling) capability is defined as a
>>> capability that allows a process to alter the modeling and hence
>>> the trust status of the platform.  In a fully orchestrated system
>>> only the trust orchestrator carry this capability bit and then
>>> drop the capability for the execution of the workload.  This is
>>> designed to prevent a security vulnerability in workloads to be
>>> leveraged to create an entity that could conduct adversarial
>>> modifications to the trust status of the platform.
>>>
>>> With the introduction of TSEM there are three generic mechanisms
>>> for implementing security contols, each with its own capability
>>> bit for management, ie:
>>>
>>> DAC - CAP_DAC_ADMIN
>> There is no CAP_DAC_ADMIN. There are several capabilities related to
>> changing the DAC state of the system.
> Our apologies, I believe we were thinking of CAP_DAC_OVERRIDE.

CAP_DAC_OVERRIDE allows you to circumvent the normal DAC checks.
It is not an administrative capability.

>
>>> MAC - CAP_MAC_ADMIN
>> Since your system implements a mandatory access control policy
>> you should be using CAP_MAC_ADMIN.
> See below.
>
>>> Security modeling - CAP_ML
>> First, the name you've chosen makes no sense at all. It isn't
>> descriptive and fails even as an abbreviation. Second, you aren't
>> doing anything that wouldn't be covered under CAP_MAC_ADMIN.
> Apologies for the name, we choose it ad-hoc as an acronym for 'Machine
> Learning' which is what TSEM uses, in potentially multiple forms, to
> implement its security controls.  I wouldn't anticipate it to be
> forthcoming from your corner, but feel free to suggest an alternative.

The name should be descriptive and unambiguous. CAP_SYS_ADMIN, for all
it's faults, tells you exactly what it's for, privileged administration
operations that are outside the scope of the system security mechanisms.
Your proposed capability should be named so as it make it obvious where
else in the system it could/should be used.

> You note above that CAP_MAC_ADMIN should be used because TSEM ends up
> implementing access control decsions that are mandatory in nature

That is correct.

> As our documentation notes, with the introduction of TSEM there are
> three mechanisms that are now available to implement security
> controls: DAC, static MAC and dynamic controls based on
> modeling/machine learning.

The static vs. dynamic distinction is fallacious. You can change Smack
rule sets at any time. You could easily create a modeling/machine learning
daemon that reads the syslog, audit files and various other system interfaces
and uses the data to reset the Smack rules to suit its idea of security.
That daemon would require CAP_MAC_ADMIN and sufficient privilege to read
the data it is interested in.

Having provided an example of a dynamic, modeling/machine learning system
for which CAP_MAC_ADMIN is appropriate, I remain of the opinion that your
proposed CAP_ML is unnecessary.

> Our premise for proposing a separate capability is that different
> methods of achieving security controls should use different
> capabilities, so that the capability controls remain orthogonal and
> independent of one another.

There are lots of people who agree with you. Unfortunately, the capability
mechanism does not scale well to large numbers of capabilities. It was
not designed (P1003.1e/2c) with fine grained privilege in mind. The use
of capabilities has been slow enough on the uptake as it is. Adding all
the capabilities that have been requested over the years would only make
it harder.

> Additionally.
>
> The mandatory controls implemented by TSEM are subtly different in
> intent from those implemented by the incumbent LSM's, since TSEM's
> controls can be generated and implemented by software developers or
> users.  You had noted in other replies that classic mandatory controls
> should only be implemented by system administrators or security
> architects.

Look at seccomp and landlock before you claim TSEM is unique in this way.

> Finally.
>
> TSEM brings with it the ability to allow the creation of security
> control namespaces that do not conflict with other security
> namespaces,

I read this several times, and can't tease out what it means. :(

>  with the exception that the non-namespaced controls will
> also exert their authority if they are 'stacked' with TSEM.  If we
> read user interest and expectations correctly, which I believe we do,
> there will only be an increasing demand for this type of security
> functionality.
>
> Given that, it will be problematic, moving forward, if the capability
> to create isolated security namespaces is not orthogonal with the
> ability to modify how a policy can be configured or managed within an
> isolated security namespace.

I don't see how "creating an isolated security namespace" isn't
a "configuraton" or "management" operation. You are going to have
some other mechanism to prevent processes in an isolated security
namespace from creating new isolated security namespaces if you
don't want them to, aren't you?

> Given this latter issue, CAP_ML probably needs a different name,
> once again, suggestions are welcome.
>
>>> Having a separate capability bit for security modeling allows DAC
>>> and classic label or path based MAC systems to be implemented in
>>> the context of a security modeling namespace.  Looking forward it
>>> is not unreasonable to consider the implementation of a modeling
>>> policy that would verify the status of extended attributes being
>>> used for label based MAC controls.
>> It seems reasonable that being trusted with the privilege to change
>> the modeling policy would imply sufficient trust to change other
>> security states where allowed. As the Smack maintainer, and having
>> introduced CAP_MAC_ADMIN, I say that there's insufficient grounds to
>> introduce a new, single purpose capability.
> First, no one, least of all our group, doubts your contributions to
> the art.
>
> We are also very confident, in the level of skills and experience in
> the fields of modeling and security operations, of the team that is
> bringing forward TSEM.
>
> Based on these experiences, as we noted above, we believe it will be
> unwise to not make the ability to control the creation, isolation and
> protection of a security namespace from the ability to modify the
> configuration of a security policy within a namespace.

Sorry, again, I read this several times and can't quite parse it.

> Secondly.
>
> With respect to the capability being 'single purpose'.  We haven't
> seen a clear pathway or discussion regarding namespaces for other
> security architectures, given the known structural issues involved
> with classic labeling or pathname based implementations.  Paul
> suggests that there is ongoing thinking on how to address this issue
> and you've noted that the stacking work needs to go in before further
> functionality can be considered.

AppArmor has a working implementation. Both SELinux and Smack have had
patches reviewed in the past. SELinux work continues, but it has been a
while since there have been postings. You're correct that no clear path
has been proposed for dealing with namespaces generically.

> The new capability bit will be available when those initiatives move
> forward.  Kernel doctrine has been that at least a single use of
> functionality must be present for a feature to be added, TSEM provides
> that initial use.

Requests for single-use capabilities come in all the time. The
capability system isn't set up to allow for them.

> Finally.
>
> In his 'ANN' document, regarding LSM submission requirements, Paul
> Moore noted that he did not want to require the need to demonstrate a
> 'community of support' around an LSM in order to avoid a 'chicken and
> egg' problem.  He further noted that LSM authors need to be able to
> guarantee that API's will be durable for 20+ years.
>
> Within the security industry there is already a 'chicken and egg'
> problem.  A new security architecture or scheme will not evolve
> without the system, at a minimum, being in the Linux kernel.  New
> security architectures do not organically appear and evolve, we can
> state this fact with significant authority.
>
> Without generic availability and use of a technology, it is difficult
> to reason how correct 20+ year guesses on needed functionality can be
> made.  So there needs to be a 'guess' on how to implement technology,
> in the most generic form that does not lock the implementation into a
> corner.
>
> We've tried to make these 'guesses' with TSEM, based on, now 15+ years
> of experience, with multiple implementations of security modeling and
> namespacing.  Our advocacy for the new capability bit, whatever it is
> named, is based on that body of experience.
>
> We have proposed what we believe is the correct implementation and
> API.  If the only way forward is an alternate implementation, we have
> conducted our due diligence, which history will document if that
> alternate implementation proves to be insufficient and constraining.

Yes, I hear you. Your arguments are fine, they just don't justify
a new, single use capability.

> Best wishes for a productive remainder of the week.

To you as well.

>
> As always,
> Dr. Greg
>
> The Quixote Project - Flailing at the Travails of Cybersecurity
