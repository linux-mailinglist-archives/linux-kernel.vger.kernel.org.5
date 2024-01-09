Return-Path: <linux-kernel+bounces-21390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B46F0828E80
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344D41F25CF1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9D13D961;
	Tue,  9 Jan 2024 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="updca0Bk"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2127.outbound.protection.outlook.com [40.107.244.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9143D960
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuYRZetgEpTqXHG/LI40e+pvC33h4Iw4CNSVkZcSr7OZs20LhKzkpTlw1NXdWEKb204zxXQ9afeuLCifgnd4k4UpkqYRohRcBp7B4tX2B2uCYKsgoO2ZkHkelVTtJTbEOna/fv36QTcAKnjIG4M2PkqBbnSBl+lhyGwFXFgGNv3krEBw26Ie0fvhXam1p4wh3CrU5Xt6HpKCH6kC3YXpeDtuh4rSnT38DdoJJCV+VNHxPR+tgYevzv7ylGdBBGrKRduCZNXE3wl6e2d2JUM9X1kX7Fwse39GgiwkOqYCxwa/EO6fPyAtSGLsp9isPhW1j0wGG6w8J8zpQXyJgoOozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/GqevnjcvZK481AUlsIeIHkJ8Hb7MydVgqVdjlUKl8=;
 b=LJemLH1OPxW45pG3tyw70Q9qzBK4GehOFDP57+2QAevHDaOOLy9MiCMeD3KMkempDsBho6syq6FGa7WpfLeuAznJIZXhn78ULk+L0Z7xqqSOqzpr630XPWmxkpItStUh3w1DU8sCh1bL9648kmg44KSa8dk/gqnuriMh3+A/ugUu9N1uIZXcrowWvNYc7mdQausMIF60ns1B7TqsPscPuGgtpfdJVecOWiyhGUB8y+RJD6t6w58r6395kta85YGSkmQOty0CyUQfCtbOMNGwbJK451kYhQR4kOr+3UmCNinXxasHvjThCj4A41nFoIHZ8oaR9nUptcldrgbmJch+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/GqevnjcvZK481AUlsIeIHkJ8Hb7MydVgqVdjlUKl8=;
 b=updca0Bkdms/LhqUQf7vGZQ/u/OUcFfalNtxlRu/Ufl6SY1op0mUvucQ+uo5rhTGV4C0wQrCcD6RDmthq44TolFXFe/3Kdms1vNEywlIYc+J+FdmAVJ8qN2jKWudirc+lKr90uPVQF/AX+EJ6gH47YLKaNV/KfCtwNFqYTlGT9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW2SPR01MB0036.prod.exchangelabs.com (2603:10b6:302:12::29) by
 LV2PR01MB7768.prod.exchangelabs.com (2603:10b6:408:14f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.25; Tue, 9 Jan 2024 20:29:07 +0000
Received: from MW2SPR01MB0036.prod.exchangelabs.com
 ([fe80::7bc3:c738:aaee:b197]) by MW2SPR01MB0036.prod.exchangelabs.com
 ([fe80::7bc3:c738:aaee:b197%3]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 20:29:07 +0000
From: D Scott Phillips <scott@os.amperecomputing.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Gavin
 Shan <gshan@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Raghavendra
 Rao Ananta <rananta@google.com>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] KVM: arm64: Workaround for Ampere AC03_CPU_36
 (exception taken to an incorrect EL)
In-Reply-To: <87sf3au0bu.wl-maz@kernel.org>
References: <20240105213251.4141-1-ilkka@os.amperecomputing.com>
 <ZZiWZkNP8Owytecw@linux.dev> <87sf3au0bu.wl-maz@kernel.org>
Date: Tue, 09 Jan 2024 12:29:08 -0800
Message-ID: <86o7dutfmz.fsf@scott-ph-mail.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:610:b3::9) To MW2SPR01MB0036.prod.exchangelabs.com
 (2603:10b6:302:12::29)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2SPR01MB0036:EE_|LV2PR01MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: cc901f94-90d8-464f-7f2d-08dc1151a0c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kE4ZW1R7PtdMAVFUD+EbylEzbR/S3MkdyCwN9QT6eb7sUmFdze5cODsI7UlIftILUp9kSjrLFrKEt+9y4ZqFrkjkyHAIYVQGZEltKUpa6MbFfNxhSVNIXmcCduvnuCfaKrxCiQzz8dBSAFUE0r9p06uol06vX3FQ4RWrkVOvPlQ0s72Lm2+Xq1GYFJ7ZfARGdK8ewGqQl0h+yUlWEjR/N2Ds+xsjAcrO43zuhFAnXQTloMcYA6laFrKxsfuWUtjHf7JSI4qtHfSiQXkBGA4DAM38iPhjXTTXetHaIoJ15vUt1ETXKbWIhSkWOA/UmFkk7KY9BM1mHOa4wlPYeqwVclGfeK0rQj33MxPyQ1Nrsd8TSz6vb5gRjhZ+auj8BKRZVRTxMeYp2RGNchE4sBDBeXYsJFpmyvR8I/AOZjqp2qnN+7niUtEfKungjXK+fWPJiwW9KdZue+XNvskr1lUNXVFDz4P5ILSAGlmueR9HOfPMQJMo77h0DvTvrAXxbBH7Eo2qnRDQp6kznuTSH9epM9h1vqRAKqv1Wlvk9BQEIcc7JHpR04fN8slvHj07ExKYYO8gHsNwn8QNhMOEI/Q026lExng9CrWAwoIDJ1GfRYJzVhGDLxLvr0ydKFZLwhJr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2SPR01MB0036.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39850400004)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66899024)(110136005)(54906003)(86362001)(52116002)(38350700005)(66476007)(66946007)(66556008)(41300700001)(6636002)(478600001)(38100700002)(4326008)(8936002)(5660300002)(83380400001)(8676002)(26005)(7416002)(9686003)(316002)(6506007)(6512007)(2906002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H1kZt3HkhFOR5G0YU+jG/hFy8Eo0J86tDoLJLNnNI9gDpk65zXQ5lkYPdEYx?=
 =?us-ascii?Q?EhutGMxFvJeYcg8G+7LJrESdFvJjWZlNVbCULRI2eQtizYnna6WuPYNpldag?=
 =?us-ascii?Q?7oqQK4nl1m5lR1Ps1sEaUFXsbit3X6qeKgy3ouTMP6aiRDVbMutTQUKzupfw?=
 =?us-ascii?Q?HlzetrIREE7REeYkiUg7L37ZLDE4xiCjCfCjMjCFdhfFXUy3pCuP+w9kxsem?=
 =?us-ascii?Q?+ZidikcqdrtW7NG5DDV62OYM65l/RmeR9D2Efrfg60bKWIVd8ph4EHLyRr5i?=
 =?us-ascii?Q?YGIfsq//L4KK7nnPHjoXNQx/Hb6GFpTOjMvyicwhd25zI8fFXvbW00UG1Al7?=
 =?us-ascii?Q?xL9bykeOcOeB8sLVcJzBdMkTBFe+Pcp8OynUh5dFrgLXNI6omKEHaC4YJE3a?=
 =?us-ascii?Q?1fcOkNgISnXG6wh46y2oAjzxAqHIbXOA7wmpqcTr8TKF8nH4MoS+V0ThnX+e?=
 =?us-ascii?Q?BXl6flBM6CqqLPswzuqdCynABnm3xpLhHh8hRL9B1z78o8UpEaXCO5Cj7ofH?=
 =?us-ascii?Q?AW4tOroa4vdsC+1P4mrkudkyYHmSPe7nrn3qYQjPMBCeaqheZaEsdaUI3iCD?=
 =?us-ascii?Q?BLc8L65DeRdHvwJ87QqLjBJSVoalEc7N6l566jn6R7I7vklmEB+QVvb9HQEF?=
 =?us-ascii?Q?z4R+jbzBfEASqVb42P11MlcaeAcczV2ZLWMAqVESsBUZ98qITnmmAftjCJTw?=
 =?us-ascii?Q?gno2xuqqAnX/h3aJV7EzFNDt26E9F+gJzbTGI2WbBQLqaaeQ3ww/OB2Y/4KP?=
 =?us-ascii?Q?rnyMmNtUwPVeHVfEWOWR9dlqWirHOiBHkqQmeoLCqKYpScjSOEAt7Cnx/JlJ?=
 =?us-ascii?Q?ijq/fcM6ZJ4xxKj7egaGUmAsszMAni1OagBdIYKI9Ko06AJs6tmLKdFBSa/K?=
 =?us-ascii?Q?OedMi9I0Amkumk4isuOAFuPuzcPSTWGKwYQ9i7hJffwXNIB8r4dYE91Z2j/o?=
 =?us-ascii?Q?3tyFERf5PS0kggkVO2C+j2jI9CNbP/8HaoJOV7ZMvUBpBU9Rag8n09Saysfz?=
 =?us-ascii?Q?Kj4Qb/7xcXjeS5B9EzbdZsDxXIzl/S5rtifiT2rAxuRRGNNvKnxld9MsnBDO?=
 =?us-ascii?Q?AJU3sv4vXlgSOLFLqeDjM3JV4GC3JkPhSElS0/cCGjDpReA8uDCZjLpLPJq4?=
 =?us-ascii?Q?HumpFCOXrXZm/Vj8JwMytqLWqPASoKrznQtM22VFA17zwg2LE3nQVlYjj8hR?=
 =?us-ascii?Q?HSn37dNUbFjSs9+tbPFnlpQNpuu+VCZrRdZyUn+VGkmR9a+qhWGkpBKUrbmo?=
 =?us-ascii?Q?MUE8OHgvDMCX3gaUkinncq0KS95/3RLjRdSamqxqBEtE+PJPSb8ifIKy3hTR?=
 =?us-ascii?Q?Rg1eXrygvRs7x71YcXCO4z5hjutBzj5uvoUOETZaGAZTrlVTxJHouam7tOZt?=
 =?us-ascii?Q?swwZ2gVMHmtaQEw8DQ0+W6IAmA0pxwsh8YImoqkesR9yXmXy3A3kYPuLfE1J?=
 =?us-ascii?Q?74Yo6tP5si/8celPoQa5dvtkRjzBDUeE1fwoLnt6JptHgQC7HW5bvhC66zQg?=
 =?us-ascii?Q?b+eKLcHlCvQdz3Hinxqe1BkGVPskAdnavJv0WihyGa8YBBwv6S+rXwjNzV5D?=
 =?us-ascii?Q?yPw0U2Q+lU4Lo5nP1shLu4cey/oyACyThNu75SVviEhvkmQ53Rh9/jpo8qDB?=
 =?us-ascii?Q?OXU10f3Dwd4bK26dNAaUtg0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc901f94-90d8-464f-7f2d-08dc1151a0c2
X-MS-Exchange-CrossTenant-AuthSource: MW2SPR01MB0036.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 20:29:06.9788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmPYjrNoCFH7Whs7v/whXPFlNZKMA14+obow5SJeoFyjECoOjEtzu2VhGir/QsMn2i3Rnn95qbRVfoZ3sNv5iCUB7wQ3nx1An6N7w4KsJ2ueSkCtsFmYUFk0td6meKQC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7768

Marc Zyngier <maz@kernel.org> writes:

> [reviewing both patches in one go, as it is way easier]
>
> On Fri, 05 Jan 2024 23:53:10 +0000,
> Oliver Upton <oliver.upton@linux.dev> wrote:
>> 
>> Hi Ilkka,
>> 
>> On Fri, Jan 05, 2024 at 01:32:51PM -0800, Ilkka Koskinen wrote:
>> > Due to erratum AC03_CPU_36 on AmpereOne, if an Asynchronous Exception
>> > (interrupts or SErrors) occurs to EL2, while EL2 software is modifying
>> > system register bits that control EL2 exception behavior, the processor
>> > may take an exception to an incorrect Exception Level.
>
> What needs to be described (both in the commit message and as part of
> the code) is under what circumstances this mis-routing happens.
>
> Is it that just clearing TGE while being at EL2 always results in the
> asynchronous exception being routed to the wrong exception level? Or
> is it a more subtle issue related to synchronisation?
>
> Also worth describing is to which other exception level is the
> exception delivered? EL1? EL3?
>
>> > 
>> > The affected system registers are HCR_EL2 and SCTLR_EL2, which contain
>> > control bits for routing and enabling of EL2 exceptions.
>
> How does SCTLR_EL2 affects interrupt delivery? Is this related to
> FEAT_NMI and SCTLR_EL2.{NMI,SPINTMASK}? Because this is the only part
> of this register that has anything to do with interrupts.
>
>> > 
>> > The issue is triggered when HGE.TGE bit is cleared while having
>> > AMO/IMO/FMO bits cleared too. To avoid the exception getting taken
>> > at a wrong Exception Level, we set AMO/IMO/FMO.
>> 
>> We toggle HCR_EL2 for other things besides TLB invalidations, and the
>> changelog does not describe why they're apparently unaffected.
>> 
>> > Suggested-by: D Scott Phillips <scott@os.amperecomputing.com>
>> > Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> 
>> This isn't an acceptable way to go about errata mitigations. Besides
>> extremely unusual circumstances, the pattern is to use a cpucap &&
>> alternatives to only enable the workaround on affected designs. We then
>> document the errata in the expected places (Kconfig and kernel
>> documentation) such that the folks saddled with maintaining this stuff
>> know how to handle it years down the line.
>
> +1. This hack will have to live forever, while the lack of
> documentation makes it totally unmaintainable. The KVM code *will*
> change in ways that cannot be anticipated today, and without
> exhaustive documentation, we will not be able to do a good job at
> maintaining this system alive by correctly mitigating the erratum.
>
>> 
>> > ---
>> >  arch/arm64/kvm/hyp/vhe/tlb.c | 12 +++++++++---
>> >  1 file changed, 9 insertions(+), 3 deletions(-)
>> > 
>> > diff --git a/arch/arm64/kvm/hyp/vhe/tlb.c b/arch/arm64/kvm/hyp/vhe/tlb.c
>> > index b32e2940df7d..c72fdd2e4549 100644
>> > --- a/arch/arm64/kvm/hyp/vhe/tlb.c
>> > +++ b/arch/arm64/kvm/hyp/vhe/tlb.c
>> > @@ -61,9 +61,15 @@ static void __tlb_switch_to_guest(struct kvm_s2_mmu *mmu,
>> >  	 * has an ISB in order to deal with this.
>> >  	 */
>> >  	__load_stage2(mmu, mmu->arch);
>> > -	val = read_sysreg(hcr_el2);
>> > -	val &= ~HCR_TGE;
>> > -	write_sysreg(val, hcr_el2);
>> > +
>> > +	/*
>> > +	 * With {E2H,TGE} == {1,0}, IMO == 1 is required so that IRQs are not
>> > +	 * all masked.
>> 
>> Huh? HCR_EL2.IMO affects the *routing* of IRQs at exception levels
>> *lower than* EL2.
>
> Yup, and there is *zero* requirement for IMO to have any particular
> value while running at EL2. As long as you're at EL2, physical
> interrupts that are not targeting EL3 are taken at EL2, full stop.

What's meant here is that when the configurations of HCR.{E2H,TGE,IMO}
== {1,0,0}, that's a "C" for irq target in the big table of IRQ target
ELs under "Establishing the target Exception level of an asynchronous
exception" meaning that no IRQs are taken, regardless of PSTATE.I.

It doesn't seem like the intent of the tlb flush code was to also mask
IRQs via HCR, which is why Ilkka proposed the change to also set IMO.

With that changed, there weren't any remaining places left that needed
the irq masking workaround which is why Ilkka added a comment instead of
a cpucap.

Agreed that this leaves open the possibility for future code running
afoul of the erratum. So I'd suggest that we make Ilkka's change to add
IMO here to take out the incidental hard IRQ masking but remove any
connection to the erratum, and then for the erratum make writes to
hcr_el2 on AmpereOne become:

mrs tmp, daif
msr daifset, #0xf
msr hcr_el2, value
isb
msr daif, tmp

