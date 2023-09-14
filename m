Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3292B7A0AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238416AbjINQVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238200AbjINQU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:20:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB61B1AE;
        Thu, 14 Sep 2023 09:20:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5RIVICMirLfkqAmTOCCd0gVbacFvlg5cXSPcujb9Tcowb3DJrvj9S68aNs5y+WEvojR3V24RLWuUvHlrmepsmSbRC+QSJPjuysdOJn0G0km5VNdqY/ujy94s8tsk5/yT3ZYNDRnAWENuRjyDwNN1WJypxiQxeuDimtDu8c5ct/fYuSkO8LzwItEDt12rv6efC3sotF2TYlDqGtlsz3cbwYG/FDbljphnzq9O4JWw/vrtoP+hqoDiu0YG5t+jCLGaEvNOFP2MyCwFFk3iBnRThRJtmfzqQ85YtS50Mal9+8pMBvQV9V1nkxpQlYw0Lg9CIqNy4T5+bvMoxS3nEmS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpHzSZnnNhfvbfnSVuVOBQCGfXMh3Z1WlSnHwhaCHsA=;
 b=XgeSOzhMaPokp2TH/TSdpnqFpet3AQxd92Wcw7hQRNdanFpMJ1ChkWMp8OsWGP845KVjQJCgIEbYO6LJG/T3S1ArkCVk/Up4yYVsdrQNEJHGdIUKj14q4Vg1yyfxUam6JqNK01YujLZnqRl+O88FP+ava0IdgHTldxgtWRbEmCoJowd7LG67iekUrYpEn7a4rjJCezI03N9ih0i/9UuqoE1UEHGFtBHboMgqTlvI7KGxo5xXIynokr7i07fSBeLvJW+PEcLNkSHooydKvHtdh6T1jntF/iM9EtafliDDL+UlskEQfEjcO2PVNi7Uy3MbpdzPk57k2eP25RbxyQl4uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpHzSZnnNhfvbfnSVuVOBQCGfXMh3Z1WlSnHwhaCHsA=;
 b=ycvbjTdUSm2UV8FLHRXdF1XmkG52sCD9/dO5NnxEy9I6F1fKuIYkDapaRiQjG75k9K/JDEkCfMox7pJU4oFF0fCznbW0sfjD3A40ZGAG0hRK5c/0gg3vsPZENnQi8ahAj7FruHOw8DS+4RlTkHDMquNOGckojLAOZMhDRG8vV3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Thu, 14 Sep
 2023 16:20:50 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9ac8:9ded:2dc2:afaf]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9ac8:9ded:2dc2:afaf%6]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 16:20:50 +0000
Message-ID: <98804f27-c2e7-74d6-d671-1eda927e19fe@amd.com>
Date:   Thu, 14 Sep 2023 11:20:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: [RESEND PATCH v4] docs: security: Confidential computing intro and
 threat model for x86 virtualization
Content-Language: en-US
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ardb@kernel.org, kraxel@redhat.com, dovmurik@linux.ibm.com,
        elena.reshetova@intel.com, dave.hansen@linux.intel.com,
        Dhaval.Giani@amd.com, michael.day@amd.com,
        pavankumar.paluri@amd.com, David.Kaplan@amd.com,
        Reshma.Lal@amd.com, Jeremy.Powell@amd.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        alexander.shishkin@linux.intel.com, thomas.lendacky@amd.com,
        tglx@linutronix.de, dgilbert@redhat.com, dinechin@redhat.com,
        linux-coco@lists.linux.dev, berrange@redhat.com, mst@redhat.com,
        tytso@mit.edu, jikos@kernel.org, joro@8bytes.org, leon@kernel.org,
        richard.weinberger@gmail.com, lukas@wunner.de, jejb@linux.ibm.com,
        cdupontd@redhat.com, jasowang@redhat.com, sameo@rivosinc.com,
        bp@alien8.de, seanjc@google.com, security@kernel.org,
        Larry Dewey <larry.dewey@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230905152656.1215119-1-carlos.bilbao@amd.com>
 <2023090537-undesired-junction-b325@gregkh>
 <4a25cfe8-39d7-1d0f-b89b-2d62bdb085c1@amd.com>
 <bb5a6655-ebaa-2ddf-0c49-6f1027ccb839@amd.com>
 <f7700d54-da02-3482-17c5-bbae36799fb5@amd.com>
In-Reply-To: <f7700d54-da02-3482-17c5-bbae36799fb5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:806:21::25) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|PH8PR12MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 290c4652-d202-4d82-a05c-08dbb53e8f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T1Aj9hM5YW2BJLeL63COMclIqZUrceU/R+37v68fqrTSM3s1BSo/DM34M87EOKkYDqpNqO3LVe8N+3t9QP2zb/m2VoBxD5aX8fB1GURbMRYc/kVFaGFQSJqB8ly96VfZ70llTapgn3eDycWZa9PcUIOEnybaiTUtH6vsa0UBonSf921WsRkcKq7SyDrO3WYf2iIidjFYK1KJR99SOxxzsrEj0eEqVDuhX9m+QfeRPlHbiaAnGTEra8VFcFo1DrQCBtzoN6Pb5XdYEkxBV0+qoPoOP1CSIk01PDuPGQ9cdBwk/CyCk6SW3g5x5pCcSlK/MSmdZQAFZpByp2DPAXCJjJgIKGVqAgVJQHrzVbtryJykpqe77GiHoFs9k639HoCSJTLgaRrDqqtO3PUrkProqk8VyJgL8gMsgWSG4cvqBwuUH0HQC3vydhAhOmOZiGBwinNS09X6DvAO48A5i6O+oyk/Jsh38cZTkg4LuPPPU/m73KOk8QAw3DUM0nDYZF6y8U7snuoCPkv4SpMA6J8YcLSrtSm9tj96+Yb8WjeGMxY48gb/StBK1k1IRn/CyADxWNdmAprm42IKwXM7icQp6RqqID5r/xDWvqMZfhFQRH4kG36OKV8uvS4m3aAAQVM70BevuUAEeGvrwJzs/HXqisSAZ/5VHbNaCrLtoH6+tCDxq8dSQwKndP1Ta+G++Isz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(396003)(376002)(1800799009)(186009)(451199024)(2906002)(7406005)(7416002)(30864003)(86362001)(2616005)(31696002)(36756003)(6512007)(6486002)(6666004)(6506007)(26005)(38100700002)(83380400001)(478600001)(6916009)(966005)(316002)(44832011)(4326008)(54906003)(15650500001)(8936002)(5660300002)(31686004)(8676002)(66476007)(66556008)(66946007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXJhL0NHTDJLeGtKOWNWeHBtMlhOM2FCc1g5MFBGV0FEVEpncnNTUWJiRGov?=
 =?utf-8?B?N21IdHNibEp0N0VnM3JGRWl6bGlvcjBKL1g5MEk3KzkwMWNDS3dLMklXOURv?=
 =?utf-8?B?WDE5SnZzcmdLdTdIQldZWHU3VVFtQzJzMzZSMUdSUDNIRHZUSUtRRU00SUpi?=
 =?utf-8?B?K0FibnhTOFJFZTRGek9DQVkzRVorYWpXSFhqRUFrWjNlbWdZdXlwUE56SnVk?=
 =?utf-8?B?QkVzQXpjODZwWEFQTWVINk00RkF4ZkMvQjNBMkI1MFFFQ1lVbDJJZThuRFVI?=
 =?utf-8?B?WDE5YzZBK2kvMDBVaVZkVy82ZUR1VDQyOUZLbFVFY2ZmeDVMYWg4OUQyV29U?=
 =?utf-8?B?TGx1dURsbVBEdEErREJLZWxNRmZISFhsUlBmdlVTcXNuVndoS2lnZ29COGZR?=
 =?utf-8?B?NVBmTTRyQ1ZuMnlIdUNlN05nUytFWEdwb1oxMlhJcXdMTHZzckhrZnV4YWJJ?=
 =?utf-8?B?QzliZkdpUUk5aitrdk10NGlGem9XRGJmb1FEQlN0TTZVcVA1dGlSdkpGTDhL?=
 =?utf-8?B?NGRtMW5SSXI3TUswNkdIMzNBZkJWN3hGWUw1WnFEN3o3RkV1Tll6UEFORTA2?=
 =?utf-8?B?KzV0bmtrYWNSRmdNRHpMb0pISGVxVFdqcUdDU0FTL01mRXhXNGY3QTB4OUtu?=
 =?utf-8?B?Z2NDY3Q4WmpFdGV4cnZwTFAxOUhUdEJOK1FaelRXaDlmZVdobkhyM3BrRGQ2?=
 =?utf-8?B?cWV6Z3Z1Q1JqaDlYQWVBRmppQTZHM2F4QnVBZXNIRjg2bUpnRTBFcElWMDNR?=
 =?utf-8?B?SVNvWThpbWE0ZTVpTk9zY0ZXRXBlSC94Ry84Yzc5VlluYVdpT21IS21ZTzEy?=
 =?utf-8?B?ZzFsZjgvQThrRmx4MDYrYzQxNFlmSURrMUNyVjBXbUwybFIvbC9wRmZoTDEy?=
 =?utf-8?B?a25FM3psMnJCUUNXVDA5bWF1S2tRZlNGOVZ3VmE2MFgwWmN4OXlHeXRDTWdI?=
 =?utf-8?B?YmhyM09RcXVjdjB0NklUOWFXU29aSC9kY0V5M2RCUmhVWlVPOEdzMm55SkY0?=
 =?utf-8?B?SmZDMGZFUHZ5dlZGZjlLR00yUUZBTnRJRDBKZDB3dkhKT2dDV1dZL2F4dW15?=
 =?utf-8?B?aVYrVEE2NWNSdlNuYURkeHBGUWtZTFgvKzdRT1Q4WnB4c1lzWFlGSU00eEpD?=
 =?utf-8?B?ckN3bXBWeTRnQnhSNW5NRG1JZmJkcFNDSWE4bXkwOUJ2OXR2Y2w2WFVqdHc2?=
 =?utf-8?B?M2dZckJSSmV6dnljZ0JpUW5ITHdUQXN4dHJsU1lybzJHZUtybVZ6TWtLSTBl?=
 =?utf-8?B?dndUcU1kaXFFVkF0dXROQUdpa01hdzQxSEJ5TmZEWmFQRzhjeWw5MlNoSFN3?=
 =?utf-8?B?Q2VaZGtVVWo4d2FxaGZzQkY1ME9PQWFkUkxrRGdoNjNKSnoyYmIrSFZMSjhm?=
 =?utf-8?B?TWxtSjRlTEs2MSs0VEhHUWt1b3J0WFo1K0hDUTZBTTNpRkt1dE9IcktSRTBQ?=
 =?utf-8?B?WUFFeWxOcDVSSTdlU0pWV1Jza1QvR2JCb2NHTlBLalZuMDYxOUlRQ1dUWmg3?=
 =?utf-8?B?QnFJdVJxSjFkbTNmWnJKcFNNOG5hd3ZuZlZlUHhraEFOSXpvSksrekcrNFVz?=
 =?utf-8?B?TWQyaW50SG8yR1M0U20zSEpJbGU4WmN3bnFTTG56Nlprc2srTmlrM08yM1BV?=
 =?utf-8?B?QWVGYXdMUi9ubE1jWS9jTzJpQllpNUM4NlZIV2h4Q1dwYU1pT1FmMkxqTjBE?=
 =?utf-8?B?WVhJQW5HdVZuWU1Tb3FHYlduaFdDcmMvb3FRbysrVlR4a0x4cXBtdGEwemRM?=
 =?utf-8?B?WitHL29QT3hLRUxxa0F4eTIzUFpVNDJkU3k4RmhxT1YyM2tSeWMxMFVWMEx2?=
 =?utf-8?B?WTBiMWU2djhpVldkNGpONHdaSGo0aFRpc21OYW9yL21sVElUV0VUNEtUL2wy?=
 =?utf-8?B?Ti9GVEQ3Q0pnZXpvT2pkRzFSeXR6bnpmZko2dFEwMHhMNFZhTUdQSWdiVnRN?=
 =?utf-8?B?YWpLVWw1cmd2ZFlMRTd5enJuODcxTVVaTWJ5ZnFVMi90L296d2Z2MFhLRE9X?=
 =?utf-8?B?cEdCb2JOQVJZRWorWHh0UXVrenBKanN2bUVNWjFZekRvTW1ZNDFrNWR5cGZV?=
 =?utf-8?B?OTN4bHhndWFtL0ZYQlpHZzBUM3lyZmNYSjl0SVNMSG1DMklpSTBsMDB3MXpx?=
 =?utf-8?Q?zbQJeLlolY3/EYWUCQj/s33IY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290c4652-d202-4d82-a05c-08dbb53e8f4a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 16:20:50.2323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADIxgsUwQkjLyAmdipJe4boJuNfRvNXu0s1gzneBUcUGP1aaQd1HKPTdOwq/7XHKqNvoLHmMhgxXA4Mi6zPn2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel developers working on confidential computing for virtualized
environments in x86 operate under a set of assumptions regarding the Linux
kernel threat model that differs from the traditional view. Historically,
the Linux threat model acknowledges attackers residing in userspace, as
well as a limited set of external attackers that are able to interact with
the kernel through networking or limited HW-specific exposed interfaces
(e.g. USB, thunderbolt). The goal of this document is to explain additional
attack vectors that arise in the virtualized confidential computing space.

Reviewed-by: Larry Dewey <larry.dewey@amd.com>
Reviewed-by: David Kaplan <david.kaplan@amd.com>
Co-developed-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>

---
V3 can be found in:
https://lwn.net/Articles/937927/
Changes since V3:
  - Drop column of potential mitigations, only describe new threats.

V2 can be found in:
  https://lore.kernel.org/lkml/20230612164727.3935657-1-carlos.bilbao@amd.com/
Changes since V2:
  - Remove pKVM from the document. Although there are clear overlaps in the
    threat models, it might be good to omit pKVM for now to avoid further
    complexity. In the future, when pKVM is more mature, we can revisit and
    discuss its inclusion.
  - Change file name to "snp-tdx-threat-model.rst".
  - Replace hyphens (dashes) for parenthesis in a parenthetical sentence.
  - Change "technology specific" for "technology-specific".

V1 can be found in:
  https://lore.kernel.org/lkml/20230327141816.2648615-1-carlos.bilbao@amd.com/
Changes since v1:

- Apply feedback from first version of the patch
- Clarify that the document applies only to a particular angle of
   confidential computing, namely confidential computing for virtualized
   environments. Also, state that the document is specific to x86 and
   that the main goal is to discuss the emerging threats.
- Change commit message and file name accordingly
- Replace AMD's link to AMD SEV SNP white paper
- Minor tweaking and clarifications

---
  Documentation/security/index.rst              |   1 +
  .../security/snp-tdx-threat-model.rst         | 253 ++++++++++++++++++
  MAINTAINERS                                   |   6 +
  3 files changed, 260 insertions(+)
  create mode 100644 Documentation/security/snp-tdx-threat-model.rst

diff --git a/Documentation/security/index.rst 
b/Documentation/security/index.rst
index 6ed8d2fa6f9e..59f8fc106cb0 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -6,6 +6,7 @@ Security Documentation
     :maxdepth: 1

     credentials
+   snp-tdx-threat-model
     IMA-templates
     keys/index
     lsm
diff --git a/Documentation/security/snp-tdx-threat-model.rst 
b/Documentation/security/snp-tdx-threat-model.rst
new file mode 100644
index 000000000000..ec66f2ed80c9
--- /dev/null
+++ b/Documentation/security/snp-tdx-threat-model.rst
@@ -0,0 +1,253 @@
+======================================================
+Confidential Computing in Linux for x86 virtualization
+======================================================
+
+.. contents:: :local:
+
+By: Elena Reshetova <elena.reshetova@intel.com> and Carlos Bilbao 
<carlos.bilbao@amd.com>
+
+Motivation
+==========
+
+Kernel developers working on confidential computing for virtualized
+environments in x86 operate under a set of assumptions regarding the Linux
+kernel threat model that differ from the traditional view. Historically,
+the Linux threat model acknowledges attackers residing in userspace, as
+well as a limited set of external attackers that are able to interact with
+the kernel through various networking or limited HW-specific exposed
+interfaces (USB, thunderbolt). The goal of this document is to explain
+additional attack vectors that arise in the confidential computing space
+and discuss the proposed protection mechanisms for the Linux kernel.
+
+Overview and terminology
+========================
+
+Confidential Computing (CoCo) is a broad term covering a wide range of
+security technologies that aim to protect the confidentiality and integrity
+of data in use (vs. data at rest or data in transit). At its core, CoCo
+solutions provide a Trusted Execution Environment (TEE), where secure data
+processing can be performed and, as a result, they are typically further
+classified into different subtypes depending on the SW that is intended
+to be run in TEE. This document focuses on a subclass of CoCo technologies
+that are targeting virtualized environments and allow running Virtual
+Machines (VM) inside TEE. From now on in this document will be referring
+to this subclass of CoCo as 'Confidential Computing (CoCo) for the
+virtualized environments (VE)'.
+
+CoCo, in the virtualization context, refers to a set of HW and/or SW
+technologies that allow for stronger security guarantees for the SW running
+inside a CoCo VM. Namely, confidential computing allows its users to
+confirm the trustworthiness of all SW pieces to include in its reduced
+Trusted Computing Base (TCB) given its ability to attest the state of these
+trusted components.
+
+While the concrete implementation details differ between technologies, all
+available mechanisms aim to provide increased confidentiality and
+integrity for the VM's guest memory and execution state (vCPU registers),
+more tightly controlled guest interrupt injection, as well as some
+additional mechanisms to control guest-host page mapping. More details on
+the x86-specific solutions can be found in
+:doc:`Intel Trust Domain Extensions (TDX) </arch/x86/tdx>` and
+`AMD Memory Encryption 
<https://www.amd.com/system/files/techdocs/sev-snp-strengthening-vm-isolation-with-integrity-protection-and-more.pdf>`_.
+
+The basic CoCo guest layout includes the host, guest, the interfaces that
+communicate guest and host, a platform capable of supporting CoCo VMs, and
+a trusted intermediary between the guest VM and the underlying platform
+that acts as a security manager. The host-side virtual machine monitor
+(VMM) typically consists of a subset of traditional VMM features and
+is still in charge of the guest lifecycle, i.e. create or destroy a CoCo
+VM, manage its access to system resources, etc. However, since it
+typically stays out of CoCo VM TCB, its access is limited to preserve the
+security objectives.
+
+In the following diagram, the "<--->" lines represent bi-directional
+communication channels or interfaces between the CoCo security manager and
+the rest of the components (data flow for guest, host, hardware) ::
+
+    +-------------------+      +-----------------------+
+    | CoCo guest VM     |<---->|                       |
+    +-------------------+      |                       |
+      | Interfaces |           | CoCo security manager |
+    +-------------------+      |                       |
+    | Host VMM          |<---->|                       |
+    +-------------------+      |                       |
+                               |                       |
+    +--------------------+     |                       |
+    | CoCo platform      |<--->|                       |
+    +--------------------+     +-----------------------+
+
+The specific details of the CoCo security manager vastly diverge between
+technologies. For example, in some cases, it will be implemented in HW
+while in others it may be pure SW.
+
+Existing Linux kernel threat model
+==================================
+
+The overall components of the current Linux kernel threat model are::
+
+     +-----------------------+      +-------------------+
+     |                       |<---->| Userspace         |
+     |                       |      +-------------------+
+     |   External attack     |         | Interfaces |
+     |       vectors         |      +-------------------+
+     |                       |<---->| Linux Kernel      |
+     |                       |      +-------------------+
+     +-----------------------+      +-------------------+
+                                    | Bootloader/BIOS   |
+                                    +-------------------+
+                                    +-------------------+
+                                    | HW platform       |
+                                    +-------------------+
+
+There is also communication between the bootloader and the kernel during
+the boot process, but this diagram does not represent it explicitly. The
+"Interfaces" box represents the various interfaces that allow
+communication between kernel and userspace. This includes system calls,
+kernel APIs, device drivers, etc.
+
+The existing Linux kernel threat model typically assumes execution on a
+trusted HW platform with all of the firmware and bootloaders included on
+its TCB. The primary attacker resides in the userspace, and all of the data
+coming from there is generally considered untrusted, unless userspace is
+privileged enough to perform trusted actions. In addition, external
+attackers are typically considered, including those with access to enabled
+external networks (e.g. Ethernet, Wireless, Bluetooth), exposed hardware
+interfaces (e.g. USB, Thunderbolt), and the ability to modify the contents
+of disks offline.
+
+Regarding external attack vectors, it is interesting to note that in most
+cases external attackers will try to exploit vulnerabilities in userspace
+first, but that it is possible for an attacker to directly target the
+kernel; particularly if the host has physical access. Examples of direct
+kernel attacks include the vulnerabilities CVE-2019-19524, CVE-2022-0435
+and CVE-2020-24490.
+
+Confidential Computing threat model and its security objectives
+===============================================================
+
+Confidential Computing adds a new type of attacker to the above list: a
+potentially misbehaving host (which can also include some part of a
+traditional VMM or all of it), which is typically placed outside of the
+CoCo VM TCB due to its large SW attack surface. It is important to note
+that this doesn’t imply that the host or VMM are intentionally
+malicious, but that there exists a security value in having a small CoCo
+VM TCB. This new type of adversary may be viewed as a more powerful type
+of external attacker, as it resides locally on the same physical machine
+(in contrast to a remote network attacker) and has control over the guest
+kernel communication with most of the HW::
+
+                                 +------------------------+
+                                 |    CoCo guest VM       |
+   +-----------------------+     |  +-------------------+ |
+   |                       |<--->|  | Userspace         | |
+   |                       |     |  +-------------------+ |
+   |   External attack     |     |     | Interfaces |     |
+   |       vectors         |     |  +-------------------+ |
+   |                       |<--->|  | Linux Kernel      | |
+   |                       |     |  +-------------------+ |
+   +-----------------------+     |  +-------------------+ |
+                                 |  | Bootloader/BIOS   | |
+   +-----------------------+     |  +-------------------+ |
+   |                       |<--->+------------------------+
+   |                       |          | Interfaces |
+   |                       |     +------------------------+
+   |     CoCo security     |<--->| Host/Host-side VMM |
+   |      manager          |     +------------------------+
+   |                       |     +------------------------+
+   |                       |<--->|   CoCo platform        |
+   +-----------------------+     +------------------------+
+
+While traditionally the host has unlimited access to guest data and can
+leverage this access to attack the guest, the CoCo systems mitigate such
+attacks by adding security features like guest data confidentiality and
+integrity protection. This threat model assumes that those features are
+available and intact.
+
+The **Linux kernel CoCo VM security objectives** can be summarized as follows:
+
+1. Preserve the confidentiality and integrity of CoCo guest's private
+memory and registers.
+
+2. Prevent privileged escalation from a host into a CoCo guest Linux kernel.
+While it is true that the host (and host-side VMM) requires some level of
+privilege to create, destroy, or pause the guest, part of the goal of
+preventing privileged escalation is to ensure that these operations do not
+provide a pathway for attackers to gain access to the guest's kernel.
+
+The above security objectives result in two primary **Linux kernel CoCo
+VM assets**:
+
+1. Guest kernel execution context.
+2. Guest kernel private memory.
+
+The host retains full control over the CoCo guest resources, and can deny
+access to them at any time. Examples of resources include CPU time, memory
+that the guest can consume, network bandwidth, etc. Because of this, the
+host Denial of Service (DoS) attacks against CoCo guests are beyond the
+scope of this threat model.
+
+The **Linux CoCo VM attack surface** is any interface exposed from a CoCo
+guest Linux kernel towards an untrusted host that is not covered by the
+CoCo technology SW/HW protection. This includes any possible
+side-channels, as well as transient execution side channels. Examples of
+explicit (not side-channel) interfaces include accesses to port I/O, MMIO
+and DMA interfaces, access to PCI configuration space, VMM-specific
+hypercalls (towards Host-side VMM), access to shared memory pages,
+interrupts allowed to be injected into the guest kernel by the host, as
+well as CoCo technology-specific hypercalls, if present. Additionally, the
+host in a CoCo system typically controls the process of creating a CoCo
+guest: it has a method to load into a guest the firmware and bootloader
+images, the kernel image together with the kernel command line. All of this
+data should also be considered untrusted until its integrity and
+authenticity is established via attestation.
+
+The table below shows a threat matrix for the CoCo guest Linux kernel but
+does not discuss potential mitigation strategies. The matrix refers to
+CoCo-specific versions of the guest, host and platform.
+
+.. list-table:: CoCo Linux guest kernel threat matrix
+   :widths: auto
+   :align: center
+   :header-rows: 1
+
+   * - Threat name
+     - Threat description
+
+   * - Guest malicious configuration
+     - A misbehaving host modifies one of the following guest's
+       configuration:
+
+       1. Guest firmware or bootloader
+
+       2. Guest kernel or module binaries
+
+       3. Guest command line parameters
+
+       This allows the host to break the integrity of the code running
+       inside a CoCo guest, and violates the CoCo security objectives.
+
+   * - CoCo guest data attacks
+     - A misbehaving host retains full control of the CoCo guest's data
+       in-transit between the guest and the host-managed physical or
+       virtual devices. This allows any attack against confidentiality,
+       integrity or freshness of such data.
+
+   * - Malformed runtime input
+     - A misbehaving host injects malformed input via any communication
+       interface used by the guest's kernel code. If the code is not
+       prepared to handle this input correctly, this can result in a host
+       --> guest kernel privilege escalation. This includes traditional
+       side-channel and/or transient execution attack vectors.
+
+   * - Malicious runtime input
+     - A misbehaving host injects a specific input value via any
+       communication interface used by the guest's kernel code. The
+       difference with the previous attack vector (malformed runtime input)
+       is that this input is not malformed, but its value is crafted to
+       impact the guest's kernel security. Examples of such inputs include
+       providing a malicious time to the guest or the entropy to the guest
+       random number generator. Additionally, the timing of such events can
+       be an attack vector on its own, if it results in a particular guest
+       kernel action (i.e. processing of a host-injected interrupt).
+       resistant to supplied host input.
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 9c186c214c54..d59f76384755 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5196,6 +5196,12 @@ S:	Orphan
  W:	http://accessrunner.sourceforge.net/
  F:	drivers/usb/atm/cxacru.c

+CONFIDENTIAL COMPUTING THREAT MODEL FOR X86 VIRTUALIZATION (SNP/TDX)
+M:    Elena Reshetova <elena.reshetova@intel.com>
+M:    Carlos Bilbao <carlos.bilbao@amd.com>
+S:    Maintained
+F:    Documentation/security/snp-tdx-threat-model.rst
+
  CONFIGFS
  M:	Joel Becker <jlbec@evilplan.org>
  M:	Christoph Hellwig <hch@lst.de>
-- 
2.34.1



