Return-Path: <linux-kernel+bounces-45256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5649B842DAF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3B91F23165
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4228D71B3B;
	Tue, 30 Jan 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="GilySuGb"
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DB171B3D;
	Tue, 30 Jan 2024 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.103.80.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706646244; cv=none; b=O9aSd/1BI1Dn4OTxS4bFvyLyaYwwOnSaUNR+oIaIyWAMH0OeJ6RasxLzAZjiiuFPstu1nYg5Q/4BvMeFOHoJ42PY3Ql2EXGRD2bxPK1vua36sFrGDRqJnHaSbgb2NlR2URrdtKhcvexzYeL5KfJHy/m1KAFZ0g0Up8n5wpdrQw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706646244; c=relaxed/simple;
	bh=rLs7iSSjuzn/fPodCelWg67OmsZ8l8YbAv4iAH9ZbD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NotOUDV6qCMcrwmq+p084O5e6L4cJ6+99Gap/WMo8J0wojvZIXXN9YRvSZLfblfuGb/WNe6DB1WX9Oy9TIeg/wQgcpmN1GGdBYTDtuuaego/+Y58Oja6en+9qW2qPvwXcB90KruLJD8+jiARq+b1Fiwi8is0aQETfChlQbE+aAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it; spf=pass smtp.mailfrom=vaga.pv.it; dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b=GilySuGb; arc=none smtp.client-ip=212.103.80.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaga.pv.it
Received: from localhost (unknown [127.0.0.1])
	by mx.kolabnow.com (Postfix) with ESMTP id 11471304D50F;
	Tue, 30 Jan 2024 21:23:49 +0100 (CET)
Authentication-Results: ext-mx-out013.mykolab.com (amavis);
 dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
 header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
	in-reply-to:content-transfer-encoding:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date:received:received:received;
	 s=dkim20160331; t=1706646223; x=1708460624; bh=sop5eATp6q2eRRuF
	1DNFQXWmPniJhQr3mduulsKl+Vs=; b=GilySuGbqo2+t62Lx4IoB2urKl/mn1v/
	KdOOhCI1NwkXVhl5nGVCJJay44vWo61f7dxaF/h9xHqDZp2goCYqT+Wy/ZeySjuU
	sa3yMurKsyCvDZBBD0S3XaQB0Ams6g3MtU+F4pFI60WCqO6WcdpP9rHOnm+yXMwR
	Ld9Oenn/tQVf4rQi+fNndn+tu3ZVU7JHE7cv2XZTIv+/kxC+TtaJDSVmBnn0cu3a
	vwn6S7UGwU1U8FqgLYZ8KrhKvZ6e06WCQwuCyCSivqAW8AMnJlbdlx4iwYwHLZne
	4vDwC9mueRw00K1Y2PvGg+OYAWmkqyqicXMSYuJW8CwkzoygXqlezFGOt5aQPqnI
	IOZfC0SFox51koA743vyHQVnGfC5cP9N1VlJTwRCidvhMrAbU9+r3ReNoEoBazGW
	d0vS+SjSNqRohT8fk92jXAkjwIIfSkSh/OHxw1vdzI6mM/HUPdbf4DrR8RGRxKPV
	4XeuS7n3KUvvGT+lPpLXzHjmPryVfSrGO2AixjyRQxdfVNOfHNAABD/A3auZzuoE
	vMCpKpJvxI2l6s1BZlemskd0zGaqtWv4IswXHytC/5wHXIr3OWiWmDB+1QRDHeSl
	RCRmaMuV2KOpSQioOSWeHe62BXzO1k08urnUOsqcafWdTdzbwXF9UVtOfKJLer5f
	DYM3LXC1n8E=
X-Virus-Scanned: amavis at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level:
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out013.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Z5t5opB2AOpV; Tue, 30 Jan 2024 21:23:43 +0100 (CET)
Received: from int-mx009.mykolab.com (unknown [10.9.13.9])
	by mx.kolabnow.com (Postfix) with ESMTPS id D92783041482;
	Tue, 30 Jan 2024 21:23:42 +0100 (CET)
Received: from ext-subm010.mykolab.com (unknown [10.9.6.10])
	by int-mx009.mykolab.com (Postfix) with ESMTPS id 5D9522093420;
	Tue, 30 Jan 2024 21:23:42 +0100 (CET)
Date: Tue, 30 Jan 2024 21:23:40 +0100
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:it_IT: first translation for locking/
Message-ID: <20240130202340.tmppiux5oiwvrtij@numero-86.vaga.pv.it>
References: <20240106233820.30454-1-federico.vaga@vaga.pv.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240106233820.30454-1-federico.vaga@vaga.pv.it>

Hi Jon,

I hope you are doing well. I do not want to disturbe you too much, I'm pinging
you just in case this patch got lost.


On Sun, Jan 07, 2024 at 12:38:20AM +0100, Federico Vaga wrote:
>To begin with:
>    - locking/index.rst
>    - locking/lockdep-design.rst
>    - locking/lockstat.rst
>    - locking/lockturture.rst
>    - locking/locktypes.rst
>
>And RCU/torture.rst to avoid broken references.
>
>Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
>---
> Documentation/RCU/torture.rst                 |   2 +-
> .../translations/it_IT/RCU/index.rst          |  19 +
> .../translations/it_IT/RCU/torture.rst        | 369 ++++++++++
> .../translations/it_IT/core-api/index.rst     |  12 +
> Documentation/translations/it_IT/index.rst    |   1 +
> .../translations/it_IT/locking/index.rst      |  20 +
> .../it_IT/locking/lockdep-design.rst          | 678 ++++++++++++++++++
> .../translations/it_IT/locking/lockstat.rst   | 230 ++++++
> .../it_IT/locking/locktorture.rst             | 181 +++++
> .../translations/it_IT/locking/locktypes.rst  | 547 ++++++++++++++
> 10 files changed, 2058 insertions(+), 1 deletion(-)
> create mode 100644 Documentation/translations/it_IT/RCU/index.rst
> create mode 100644 Documentation/translations/it_IT/RCU/torture.rst
> create mode 100644 Documentation/translations/it_IT/locking/index.rst
> create mode 100644 Documentation/translations/it_IT/locking/lockdep-design.rst
> create mode 100644 Documentation/translations/it_IT/locking/lockstat.rst
> create mode 100644 Documentation/translations/it_IT/locking/locktorture.rst
> create mode 100644 Documentation/translations/it_IT/locking/locktypes.rst
>
>diff --git a/Documentation/RCU/torture.rst b/Documentation/RCU/torture.rst
>index b3b6dfa85248..f04730366069 100644
>--- a/Documentation/RCU/torture.rst
>+++ b/Documentation/RCU/torture.rst
>@@ -318,7 +318,7 @@ Suppose that a previous kvm.sh run left its output in this directory::
>
> 	tools/testing/selftests/rcutorture/res/2022.11.03-11.26.28
>
>-Then this run can be re-run without rebuilding as follow:
>+Then this run can be re-run without rebuilding as follow::
>
> 	kvm-again.sh tools/testing/selftests/rcutorture/res/2022.11.03-11.26.28
>
>diff --git a/Documentation/translations/it_IT/RCU/index.rst b/Documentation/translations/it_IT/RCU/index.rst
>new file mode 100644
>index 000000000000..22adf1d58752
>--- /dev/null
>+++ b/Documentation/translations/it_IT/RCU/index.rst
>@@ -0,0 +1,19 @@
>+.. SPDX-License-Identifier: GPL-2.0
>+
>+.. _it_rcu_concepts:
>+
>+===============
>+Concetti su RCU
>+===============
>+
>+.. toctree::
>+   :maxdepth: 3
>+
>+   torture
>+
>+.. only:: subproject and html
>+
>+   Indici
>+   ======
>+
>+   * :ref:`genindex`
>diff --git a/Documentation/translations/it_IT/RCU/torture.rst b/Documentation/translations/it_IT/RCU/torture.rst
>new file mode 100644
>index 000000000000..79d9e6932acc
>--- /dev/null
>+++ b/Documentation/translations/it_IT/RCU/torture.rst
>@@ -0,0 +1,369 @@
>+.. SPDX-License-Identifier: GPL-2.0
>+
>+.. include:: ../disclaimer-ita.rst
>+
>+=============================================
>+Le operazioni RCU per le verifiche *torture*
>+=============================================
>+
>+CONFIG_RCU_TORTURE_TEST
>+=======================
>+
>+L'opzione CONFIG_RCU_TORTURE_TEST è disponibile per tutte le implementazione di
>+RCU. L'opzione creerà un modulo rcutorture che potrete caricare per avviare le
>+verifiche. La verifica userà printk() per riportare lo stato, dunque potrete
>+visualizzarlo con dmesg (magari usate grep per filtrare "torture"). Le verifiche
>+inizieranno al caricamento, e si fermeranno alla sua rimozione.
>+
>+I parametri di modulo hanno tutti il prefisso "rcutortute.", vedere
>+Documentation/admin-guide/kernel-parameters.txt.
>+
>+Rapporto
>+========
>+
>+Il rapporto sulle verifiche si presenta nel seguente modo::
>+
>+	rcu-torture:--- Start of test: nreaders=16 nfakewriters=4 stat_interval=30 verbose=0 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4
>+	rcu-torture: rtc:           (null) ver: 155441 tfle: 0 rta: 155441 rtaf: 8884 rtf: 155440 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 3055767
>+	rcu-torture: Reader Pipe:  727860534 34213 0 0 0 0 0 0 0 0 0
>+	rcu-torture: Reader Batch:  727877838 17003 0 0 0 0 0 0 0 0 0
>+	rcu-torture: Free-Block Circulation:  155440 155440 155440 155440 155440 155440 155440 155440 155440 155440 0
>+	rcu-torture:--- End of test: SUCCESS: nreaders=16 nfakewriters=4 stat_interval=30 verbose=0 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4
>+
>+Sulla maggior parte dei sistemi questo rapporto si produce col comando "dmesg |
>+grep torture:". Su configurazioni più esoteriche potrebbe essere necessario
>+usare altri comandi per visualizzare i messaggi di printk(). La funzione
>+printk() usa KERN_ALERT, dunque i messaggi dovrebbero essere ben visibili. ;-)
>+
>+La prima e l'ultima riga mostrano i parametri di module di rcutorture, e solo
>+sull'ultima riga abbiamo il risultato finale delle verifiche effettuate che può
>+essere "SUCCESS" (successo) or "FAILURE" (insuccesso).
>+
>+Le voci sono le seguenti:
>+
>+* "rtc": L'indirizzo in esadecimale della struttura attualmente visibile dai
>+   lettori.
>+
>+* "ver": Il numero di volte dall'avvio che il processo scrittore di RCU ha
>+  cambiato la struttura visible ai lettori.
>+
>+* "tfle": se non è zero, indica la lista di strutture "torture freelist" da
>+  mettere in "rtc" è vuota. Questa condizione è importante perché potrebbe
>+  illuderti che RCU stia funzionando mentre invece non è il caso. :-/
>+
>+* "rta": numero di strutture allocate dalla lista "torture freelist".
>+
>+* "rtaf": il numero di allocazioni fallite dalla lista "torture freelist" a
>+  causa del fatto che fosse vuota. Non è inusuale che sia diverso da zero, ma è
>+  un brutto segno se questo numero rappresenta una frazione troppo alta di
>+  "rta".
>+
>+* "rtf": il numero di rilasci nella lista "torture freelist"
>+
>+* "rtmbe": Un valore diverso da zero indica che rcutorture crede che
>+  rcu_assign_pointer() e rcu_dereference() non funzionino correttamente. Il
>+  valore dovrebbe essere zero.
>+
>+* "rtbe": un valore diverso da zero indica che le funzioni della famiglia
>+  rcu_barrier() non funzionano correttamente.
>+
>+* "rtbke": rcutorture è stato capace di creare dei kthread real-time per forzare
>+  l'inversione di priorità di RCU. Il valore dovrebbe essere zero.
>+
>+* "rtbre": sebbene rcutorture sia riuscito a creare dei kthread capaci di
>+  forzare l'inversione di priorità, non è riuscito però ad impostarne la
>+  priorità real-time al livello 1. Il valore dovrebbe essere zero.
>+
>+* "rtbf": Il numero di volte che è fallita la promozione della priorità per
>+  risolvere un'inversione.
>+
>+* "rtb": Il numero di volte che rcutorture ha provato a forzare l'inversione di
>+  priorità. Il valore dovrebbe essere diverso da zero Se state verificando la
>+  promozione della priorità col parametro "test_bootst".
>+
>+* "nt": il numero di volte che rcutorture ha eseguito codice lato lettura
>+  all'interno di un gestore di *timer*. Questo valore dovrebbe essere diverso da
>+  zero se avete specificato il parametro "irqreader".
>+
>+* "Reader Pipe": un istogramma dell'età delle strutture viste dai lettori. RCU
>+  non funziona correttamente se una qualunque voce, dalla terza in poi, ha un
>+  valore diverso da zero. Se dovesse succedere, rcutorture stampa la stringa
>+  "!!!" per renderlo ben visibile. L'età di una struttura appena creata è zero,
>+  diventerà uno quando sparisce dalla visibilità di un lettore, e incrementata
>+  successivamente per ogni periodo di grazia; infine rilasciata dopo essere
>+  passata per (RCU_TORTURE_PIPE_LEN-2) periodi di grazia.
>+
>+  L'istantanea qui sopra è stata presa da una corretta implementazione di RCU.
>+  Se volete vedere come appare quando non funziona, sbizzarritevi nel romperla.
>+  ;-)
>+
>+* "Reader Batch": un istogramma di età di strutture viste dai lettori, ma
>+  conteggiata in termini di lotti piuttosto che periodi. Anche qui dalla terza
>+  voce in poi devono essere zero. La ragione d'esistere di questo rapporto è che
>+  a volte è più facile scatenare un terzo valore diverso da zero qui piuttosto
>+  che nella lista "Reader Pipe".
>+
>+* "Free-Block Circulation": il numero di strutture *torture* che hanno raggiunto
>+  un certo punto nella catena. Il primo numero dovrebbe corrispondere
>+  strettamente al numero di strutture allocate; il secondo conta quelle rimosse
>+  dalla vista dei lettori. Ad eccezione dell'ultimo valore, gli altri
>+  corrispondono al numero di passaggi attraverso il periodo di grazia. L'ultimo
>+  valore dovrebbe essere zero, perché viene incrementato solo se il contatore
>+  della struttura torture viene in un qualche modo incrementato oltre il
>+  normale.
>+
>+Una diversa implementazione di RCU potrebbe fornire informazioni aggiuntive. Per
>+esempio, *Tree SRCU* fornisce anche la seguente riga::
>+
>+	srcud-torture: Tree SRCU per-CPU(idx=0): 0(35,-21) 1(-4,24) 2(1,1) 3(-26,20) 4(28,-47) 5(-9,4) 6(-10,14) 7(-14,11) T(1,6)
>+
>+Questa riga mostra lo stato dei contatori per processore, in questo caso per
>+*Tree SRCU*, usando un'allocazione dinamica di srcu_struct (dunque "srcud-"
>+piuttosto che "srcu-"). I numeri fra parentesi sono i valori del "vecchio"
>+contatore e di quello "corrente" per ogni processore. Il valore "idx" mappa
>+questi due valori nell'array, ed è utile per il *debug*. La "T" finale contiene
>+il valore totale dei contatori.
>+
>+Uso su specifici kernel
>+=======================
>+
>+A volte può essere utile eseguire RCU torture su un kernel già compilato, ad
>+esempio quando lo si sta per mettere in proeduzione. In questo caso, il kernel
>+dev'essere compilato con CONFIG_RCU_TORTUE_TEST=m, cosicché le verifiche possano
>+essere avviate usano modprobe e terminate con rmmod.
>+
>+Per esempio, potreste usare questo script::
>+
>+	#!/bin/sh
>+
>+	modprobe rcutorture
>+	sleep 3600
>+	rmmod rcutorture
>+	dmesg | grep torture:
>+
>+Potete controllare il rapporto verificando manualmente la presenza del marcatore
>+di errore "!!!". Ovviamente, siete liberi di scriverne uno più elaborato che
>+identifichi automaticamente gli errori. Il comando "rmmod" forza la stampa di
>+"SUCCESS" (successo), "FAILURE" (fallimento), o "RCU_HOTPLUG". I primi due sono
>+autoesplicativi; invece, l'ultimo indica che non son stati trovati problemi in
>+RCU, tuttavia ci sono stati problemi con CPU-hotplug.
>+
>+
>+Uso sul kernel di riferimento
>+=============================
>+
>+Quando si usa rcutorture per verificare modifiche ad RCU stesso, spesso è
>+necessario compilare un certo numero di kernel usando configurazioni diverse e
>+con parametri d'avvio diversi. In questi casi, usare modprobe ed rmmod potrebbe
>+richiedere molto tempo ed il processo essere suscettibile ad errori.
>+
>+Dunque, viene messo a disposizione il programma
>+tools/testing/selftests/rcutorture/bin/kvm.sh per le architetture x86, arm64 e
>+powerpc. Di base, eseguirà la serie di verifiche elencate in
>+tools/testing/selftests/rcutorture/configs/rcu/CFLIST. Ognuna di queste verrà
>+eseguita per 30 minuti in una macchina virtuale con uno spazio utente minimale
>+fornito da un initrd generato automaticamente. Al completamento, gli artefatti
>+prodotti e i messaggi vengono analizzati alla ricerca di errori, ed i risultati
>+delle esecuzioni riassunti in un rapporto.
>+
>+Su grandi sistemi, le verifiche di rcutorture posso essere velocizzare passano a
>+kvm.sh l'argomento --cpus. Per esempio, su un sistema a 64 processori, "--cpus
>+43" userà fino a 43 processori per eseguire contemporaneamente le verifiche. Su
>+un kernel v5.4 per eseguire tutti gli scenari in due serie, riduce il tempo
>+d'esecuzione da otto ore a un'ora (senza contare il tempo per compilare sedici
>+kernel). L'argomento "--dryrun sched" non eseguirà verifiche, piuttosto vi
>+informerà su come queste verranno organizzate in serie. Questo può essere utile
>+per capire quanti processori riservare per le verifiche in --cpus.
>+
>+Non serve eseguire tutti gli scenari di verifica per ogni modifica. Per esempio,
>+per una modifica a Tree SRCU potete eseguire gli scenari SRCU-N e SRCU-P. Per
>+farlo usate l'argomento --configs di kvm.sh in questo modo: "--configs 'SRCU-N
>+SRCU-P'". Su grandi sistemi si possono eseguire più copie degli stessi scenari,
>+per esempio, un hardware che permette di eseguire 448 thread, può eseguire 5
>+istanze complete contemporaneamente. Per farlo::
>+
>+	kvm.sh --cpus 448 --configs '5*CFLIST'
>+
>+Oppure, lo stesso sistema, può eseguire contemporaneamente 56 istanze dello
>+scenario su otto processori::
>+
>+	kvm.sh --cpus 448 --configs '56*TREE04'
>+
>+O ancora 28 istanze per ogni scenario su otto processori::
>+
>+	kvm.sh --cpus 448 --configs '28*TREE03 28*TREE04'
>+
>+Ovviamente, ogni esecuzione utilizzerà della memoria. Potete limitarne l'uso con
>+l'argomento --memory, che di base assume il valore 512M. Per poter usare valori
>+piccoli dovrete disabilitare le verifiche *callback-flooding* usando il
>+parametro --bootargs che vedremo in seguito.
>+
>+A volte è utile avere informazioni aggiuntive di debug, in questo caso potete
>+usare il parametro --kconfig, per esempio, ``--kconfig
>+'CONFIG_RCU_EQS_DEBUG=y'``. In aggiunta, ci sono i parametri --gdb, --kasan, and
>+kcsan. Da notare che --gdb vi limiterà all'uso di un solo scenario per
>+esecuzione di kvm.sh e richiede di avere anche un'altra finestra aperta dalla
>+quale eseguire ``gdb`` come viene spiegato dal programma.
>+
>+Potete passare anche i parametri d'avvio del kernel, per esempio, per
>+controllare i parametri del modulo rcutorture. Per esempio, per verificare
>+modifiche del codice RCU CPU stall-warning, usate ``bootargs
>+'rcutorture.stall_cpu=30``. Il programma riporterà un fallimento, ossia il
>+risultato della verifica. Come visto in precedenza, ridurre la memoria richiede
>+la disabilitazione delle verifiche *callback-flooding*::
>+
>+	kvm.sh --cpus 448 --configs '56*TREE04' --memory 128M \
>+		--bootargs 'rcutorture.fwd_progress=0'
>+
>+A volte tutto quello che serve è una serie completa di compilazioni del kernel.
>+Questo si ottiene col parametro --buildonly.
>+
>+Il parametro --duration sovrascrive quello di base di 30 minuti. Per esempio,
>+con ``--duration 2d`` l'esecuzione sarà di due giorni, ``--duraction 5min`` di
>+cinque minuti, e ``--duration 45s`` di 45 secondi. L'ultimo può essere utile per
>+scovare rari errori nella sequenza d'avvio.
>+
>+Infine, il parametro --trust-make permette ad ogni nuova compilazione del kernel
>+di riutilizzare tutto il possibile da quelle precedenti. Da notare che senza il
>+parametro --trust-make, i vostri file di *tag* potrebbero essere distrutti.
>+
>+Ci sono altri parametri più misteriosi che sono documentati nel codice sorgente
>+dello programma kvm.sh.
>+
>+Se un'esecuzione contiene degli errori, il loro numero durante la compilazione e
>+all'esecuzione verranno elencati alla fine fra i risultati di kvm.sh (che vi
>+consigliamo caldamente di reindirizzare verso un file). I file prodotti dalla
>+compilazione ed i risultati stampati vengono salvati, usando un riferimento
>+temporale, nelle cartella tools/testing/selftests/rcutorture/res. Una cartella
>+di queste cartelle può essere fornita a kvm-find-errors.sh per estrarne gli
>+errori. Per esempio::
>+
>+	tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh \
>+		tools/testing/selftests/rcutorture/res/2020.01.20-15.54.23
>+
>+Tuttavia, molto spesso è più conveniente aprire i file direttamente. I file
>+riguardanti tutti gli scenari di un'esecuzione di trovano nella cartella
>+principale (2020.01.20-15.54.23 nell'esempio precedente), mentre quelli
>+specifici per scenario si trovano in sotto cartelle che prendono il nome dello
>+scenario stesso (per esempio, "TREE04"). Se un dato scenario viene eseguito più
>+di una volta (come abbiamo visto con "--configs '56*TREE04'"), allora dalla
>+seconda esecuzione in poi le sottocartelle includeranno un numero di
>+progressione, per esempio "TREE04.2", "TREE04.3", e via dicendo.
>+
>+Il file solitamente più usato nella cartella principale è testid.txt. Se la
>+verifica viene eseguita in un repositorio git, allora questo file conterrà il
>+*commit* sul quale si basano le verifiche, mentre tutte le modifiche non
>+registrare verranno mostrate in formato diff.
>+
>+I file solitamente più usati nelle cartelle di scenario sono:
>+
>+.config
>+  Questo file contiene le opzioni di Kconfig
>+
>+Make.out
>+  Questo file contiene il risultato di compilazione per uno specifico scenario
>+
>+console.log
>+  Questo file contiene il risultato d'esecuzione per uno specifico scenario.
>+  Questo file può essere esaminato una volta che il kernel è stato avviato,
>+  ma potrebbe non esistere se l'avvia non è fallito.
>+
>+vmlinux
>+  Questo file contiene il kernel, e potrebbe essere utile da esaminare con
>+  programmi come pbjdump e gdb
>+
>+Ci sono altri file, ma vengono usati meno. Molti sono utili all'analisi di
>+rcutorture stesso o dei suoi programmi.
>+
>+Nel kernel v5.4, su un sistema a 12 processori, un'esecuzione senza errori
>+usando gli scenari di base produce il seguente risultato::
>+
>+    SRCU-N ------- 804233 GPs (148.932/s) [srcu: g10008272 f0x0 ]
>+    SRCU-P ------- 202320 GPs (37.4667/s) [srcud: g1809476 f0x0 ]
>+    SRCU-t ------- 1122086 GPs (207.794/s) [srcu: g0 f0x0 ]
>+    SRCU-u ------- 1111285 GPs (205.794/s) [srcud: g1 f0x0 ]
>+    TASKS01 ------- 19666 GPs (3.64185/s) [tasks: g0 f0x0 ]
>+    TASKS02 ------- 20541 GPs (3.80389/s) [tasks: g0 f0x0 ]
>+    TASKS03 ------- 19416 GPs (3.59556/s) [tasks: g0 f0x0 ]
>+    TINY01 ------- 836134 GPs (154.84/s) [rcu: g0 f0x0 ] n_max_cbs: 34198
>+    TINY02 ------- 850371 GPs (157.476/s) [rcu: g0 f0x0 ] n_max_cbs: 2631
>+    TREE01 ------- 162625 GPs (30.1157/s) [rcu: g1124169 f0x0 ]
>+    TREE02 ------- 333003 GPs (61.6672/s) [rcu: g2647753 f0x0 ] n_max_cbs: 35844
>+    TREE03 ------- 306623 GPs (56.782/s) [rcu: g2975325 f0x0 ] n_max_cbs: 1496497
>+    CPU count limited from 16 to 12
>+    TREE04 ------- 246149 GPs (45.5831/s) [rcu: g1695737 f0x0 ] n_max_cbs: 434961
>+    TREE05 ------- 314603 GPs (58.2598/s) [rcu: g2257741 f0x2 ] n_max_cbs: 193997
>+    TREE07 ------- 167347 GPs (30.9902/s) [rcu: g1079021 f0x0 ] n_max_cbs: 478732
>+    CPU count limited from 16 to 12
>+    TREE09 ------- 752238 GPs (139.303/s) [rcu: g13075057 f0x0 ] n_max_cbs: 99011
>+
>+Ripetizioni
>+===========
>+
>+Immaginate di essere alla caccia di un raro problema che si verifica all'avvio.
>+Potreste usare kvm.sh, tuttavia questo ricompilerebbe il kernel ad ogni
>+esecuzione. Se avete bisogno di (diciamo) 1000 esecuzioni per essere sicuri di
>+aver risolto il problema, allora queste inutili ricompilazioni possono diventare
>+estremamente fastidiose.
>+
>+Per questo motivo esiste kvm-again.sh.
>+
>+Immaginate che un'esecuzione precedente di kvm.sh abbia lasciato i suoi
>+artefatti nella cartella::
>+
>+	tools/testing/selftests/rcutorture/res/2022.11.03-11.26.28
>+
>+Questa esecuzione può essere rieseguita senza ricompilazioni::
>+
>+	kvm-again.sh tools/testing/selftests/rcutorture/res/2022.11.03-11.26.28
>+
>+Alcuni dei parametri originali di kvm.sh possono essere sovrascritti, in
>+particolare --duration e --bootargs. Per esempio::
>+
>+	kvm-again.sh tools/testing/selftests/rcutorture/res/2022.11.03-11.26.28 \
>+		--duration 45s
>+
>+rieseguirebbe il test precedente, ma solo per 45 secondi, e quindi aiutando a
>+trovare quel raro problema all'avvio sopracitato.
>+
>+Esecuzioni distribuite
>+======================
>+
>+Sebbene kvm.sh sia utile, le sue verifiche sono limitate ad un singolo sistema.
>+Non è poi così difficile usare un qualsiasi ambiente di sviluppo per eseguire
>+(diciamo) 5 istanze di kvm.sh su altrettanti sistemi, ma questo avvierebbe
>+inutili ricompilazioni del kernel. In aggiunta, il processo di distribuzione
>+degli scenari di verifica per rcutorture sui sistemi disponibili richiede
>+scrupolo perché soggetto ad errori.
>+
>+Per questo esiste kvm-remote.sh.
>+
>+Se il seguente comando funziona::
>+
>+	ssh system0 date
>+
>+e funziona anche per system1, system2, system3, system4, e system5, e tutti
>+questi sistemi hanno 64 CPU, allora potere eseguire::
>+
>+	kvm-remote.sh "system0 system1 system2 system3 system4 system5" \
>+		--cpus 64 --duration 8h --configs "5*CFLIST"
>+
>+Questo compilerà lo scenario di base sul sistema locale, poi lo distribuirà agli
>+altri cinque sistemi elencati fra i parametri, ed eseguirà ogni scenario per
>+otto ore. Alla fine delle esecuzioni, i risultati verranno raccolti, registrati,
>+e stampati. La maggior parte dei parametri di kvm.sh possono essere usati con
>+kvm-remote.sh, tuttavia la lista dei sistemi deve venire sempre per prima.
>+
>+L'argomento di kvm.sh ``--dryrun scenarios`` può essere utile per scoprire
>+quanti scenari potrebbero essere eseguiti in gruppo di sistemi.
>+
>+Potete rieseguire anche una precedente esecuzione remota come abbiamo già fatto
>+per kvm.sh::
>+
>+	kvm-remote.sh "system0 system1 system2 system3 system4 system5" \
>+		tools/testing/selftests/rcutorture/res/2022.11.03-11.26.28-remote \
>+		--duration 24h
>+
>+In questo caso, la maggior parte dei parametri di kvm-again.sh possono essere
>+usati dopo il percorso alla cartella contenente gli artefatti dell'esecuzione da
>+ripetere.
>diff --git a/Documentation/translations/it_IT/core-api/index.rst b/Documentation/translations/it_IT/core-api/index.rst
>index cc4c4328ad03..dad20402d11b 100644
>--- a/Documentation/translations/it_IT/core-api/index.rst
>+++ b/Documentation/translations/it_IT/core-api/index.rst
>@@ -10,6 +10,18 @@ Utilità di base
>
>    symbol-namespaces
>
>+Primitive di sincronizzazione
>+=============================
>+
>+Come Linux impedisce che tutto si verifichi contemporaneamente. Consultate
>+Documentation/translations/it_IT/locking/index.rst per maggiorni informazioni
>+sul tema.
>+
>+.. toctree::
>+   :maxdepth: 1
>+
>+   ../RCU/index
>+
> .. only:: subproject and html
>
>    Indices
>diff --git a/Documentation/translations/it_IT/index.rst b/Documentation/translations/it_IT/index.rst
>index b95dfa1ded04..51a15bf37577 100644
>--- a/Documentation/translations/it_IT/index.rst
>+++ b/Documentation/translations/it_IT/index.rst
>@@ -91,6 +91,7 @@ interfacciarsi con il resto del kernel.
>    :maxdepth: 1
>
>    core-api/index
>+   Sincronizzazione nel kernel <locking/index>
>
> Strumenti e processi per lo sviluppo
> ====================================
>diff --git a/Documentation/translations/it_IT/locking/index.rst b/Documentation/translations/it_IT/locking/index.rst
>new file mode 100644
>index 000000000000..19963d33e84d
>--- /dev/null
>+++ b/Documentation/translations/it_IT/locking/index.rst
>@@ -0,0 +1,20 @@
>+.. SPDX-License-Identifier: GPL-2.0
>+
>+================
>+Sincronizzazione
>+================
>+
>+.. toctree::
>+    :maxdepth: 1
>+
>+    locktypes
>+    lockdep-design
>+    lockstat
>+    locktorture
>+
>+.. only::  subproject and html
>+
>+   Indici
>+   ======
>+
>+   * :ref:`genindex`
>diff --git a/Documentation/translations/it_IT/locking/lockdep-design.rst b/Documentation/translations/it_IT/locking/lockdep-design.rst
>new file mode 100644
>index 000000000000..9ed00d8cf280
>--- /dev/null
>+++ b/Documentation/translations/it_IT/locking/lockdep-design.rst
>@@ -0,0 +1,678 @@
>+.. SPDX-License-Identifier: GPL-2.0
>+
>+.. include:: ../disclaimer-ita.rst
>+
>+Validatore di sincronizzazione durante l'esecuzione
>+===================================================
>+
>+Classi di blocchi
>+-----------------
>+
>+L'oggetto su cui il validatore lavora è una "classe" di blocchi.
>+
>+Una classe di blocchi è un gruppo di blocchi che seguono le stesse regole di
>+sincronizzazione, anche quando i blocchi potrebbero avere più istanze (anche
>+decine di migliaia). Per esempio un blocco nella struttura inode è una classe,
>+mentre ogni inode sarà un'istanza di questa classe di blocco.
>+
>+Il validatore traccia lo "stato d'uso" di una classe di blocchi e le sue
>+dipendenze con altre classi. L'uso di un blocco indica come quel blocco viene
>+usato rispetto al suo contesto d'interruzione, mentre le dipendenze di un blocco
>+possono essere interpretate come il loro ordine; per esempio L1 -> L2 suggerisce
>+che un processo cerca di acquisire L2 mentre già trattiene L1. Dal punto di
>+vista di lockdep, i due blocchi (L1 ed L2) non sono per forza correlati: quella
>+dipendenza indica solamente l'ordine in cui sono successe le cose. Il validatore
>+verifica permanentemente la correttezza dell'uso dei blocchi e delle loro
>+dipendenze, altrimenti ritornerà un errore.
>+
>+Il comportamento di una classe di blocchi viene costruito dall'insieme delle sue
>+istanze. Una classe di blocco viene registrata alla creazione della sua prima
>+istanza, mentre tutte le successive istanze verranno mappate; dunque, il loro
>+uso e le loro dipendenze contribuiranno a costruire quello della classe. Una
>+classe di blocco non sparisce quando sparisce una sua istanza, ma può essere
>+rimossa quando il suo spazio in memoria viene reclamato. Per esempio, questo
>+succede quando si rimuove un modulo, o quando una *workqueue* viene eliminata.
>+
>+Stato
>+-----
>+
>+Il validatore traccia l'uso cronologico delle classi di blocchi e ne divide
>+l'uso in categorie (4 USI * n STATI + 1).
>+
>+I quattro USI possono essere:
>+
>+- 'sempre trattenuto nel contesto <STATO>'
>+- 'sempre trattenuto come blocco di lettura nel contesto <STATO>'
>+- 'sempre trattenuto con <STATO> abilitato'
>+- 'sempre trattenuto come blocco di lettura con <STATO> abilitato'
>+
>+gli `n` STATI sono codificati in kernel/locking/lockdep_states.h, ad oggi
>+includono:
>+
>+- hardirq
>+- softirq
>+
>+infine l'ultima categoria è:
>+
>+- 'sempre trattenuto'                                  [ == !unused        ]
>+
>+Quando vengono violate le regole di sincronizzazione, questi bit di utilizzo
>+vengono presentati nei messaggi di errore di sincronizzazione, fra parentesi
>+graffe, per un totale di `2 * n` (`n`: bit STATO). Un esempio inventato::
>+
>+   modprobe/2287 is trying to acquire lock:
>+    (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
>+
>+   but task is already holding lock:
>+    (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
>+
>+Per un dato blocco, da sinistra verso destra, la posizione del bit indica l'uso
>+del blocco e di un eventuale blocco di lettura, per ognuno degli `n` STATI elencati
>+precedentemente. Il carattere mostrato per ogni bit indica:
>+
>+   ===  ===========================================================================
>+   '.'  acquisito con interruzioni disabilitate fuori da un contesto d'interruzione
>+   '-'  acquisito in contesto d'interruzione
>+   '+'  acquisito con interruzioni abilitate
>+   '?'  acquisito in contesto d'interruzione con interruzioni abilitate
>+   ===  ===========================================================================
>+
>+Il seguente esempio mostra i bit::
>+
>+    (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
>+                         ||||
>+                         ||| \-> softirq disabilitati e fuori da un contesto di softirq
>+                         || \--> acquisito in un contesto di softirq
>+                         | \---> hardirq disabilitati e fuori da un contesto di hardirq
>+                          \----> acquisito in un contesto di hardirq
>+
>+Per un dato STATO, che il blocco sia mai stato acquisito in quel contesto di
>+STATO, o che lo STATO sia abilitato, ci lascia coi quattro possibili scenari
>+mostrati nella seguente tabella. Il carattere associato al bit indica con
>+esattezza in quale scenario ci si trova al momento del rapporto.
>+
>+  +---------------+---------------+------------------+
>+  |               | irq abilitati | irq disabilitati |
>+  +---------------+---------------+------------------+
>+  | sempre in irq |      '?'      |       '-'        |
>+  +---------------+---------------+------------------+
>+  | mai in irq    |      '+'      |       '.'        |
>+  +---------------+---------------+------------------+
>+
>+Il carattere '-' suggerisce che le interruzioni sono disabilitate perché
>+altrimenti verrebbe mostrato il carattere '?'. Una deduzione simile può essere
>+fatta anche per '+'
>+
>+I blocchi inutilizzati (ad esempio i mutex) non possono essere fra le cause di
>+un errore.
>+
>+Regole dello stato per un blocco singolo
>+----------------------------------------
>+
>+Avere un blocco sicuro in interruzioni (*irq-safe*) significa che è sempre stato
>+usato in un contesto d'interruzione, mentre un blocco insicuro in interruzioni
>+(*irq-unsafe*) significa che è sempre stato acquisito con le interruzioni
>+abilitate.
>+
>+Una classe softirq insicura è automaticamente insicura anche per hardirq. I
>+seguenti stati sono mutualmente esclusivi: solo una può essere vero quando viene
>+usata una classe di blocco::
>+
>+ <hardirq-safe> o <hardirq-unsafe>
>+ <softirq-safe> o <softirq-unsafe>
>+
>+Questo perché se un blocco può essere usato in un contesto di interruzioni
>+(sicuro in interruzioni), allora non può mai essere acquisito con le
>+interruzioni abilitate (insicuro in interruzioni). Altrimenti potrebbe
>+verificarsi uno stallo. Per esempio, questo blocco viene acquisito, ma prima di
>+essere rilasciato il contesto d'esecuzione viene interrotto nuovamente, e quindi
>+si tenterà di acquisirlo nuovamente. Questo porterà ad uno stallo, in
>+particolare uno stallo ricorsivo.
>+
>+Il validatore rileva e riporta gli usi di blocchi che violano queste regole per
>+blocchi singoli.
>+
>+Regole per le dipendenze di blocchi multipli
>+--------------------------------------------
>+
>+La stessa classe di blocco non deve essere acquisita due volte, questo perché
>+potrebbe portare ad uno blocco ricorsivo e dunque ad uno stallo.
>+
>+Inoltre, due blocchi non possono essere trattenuti in ordine inverso::
>+
>+ <L1> -> <L2>
>+ <L2> -> <L1>
>+
>+perché porterebbe ad uno stallo - chiamato stallo da blocco inverso - in cui si
>+cerca di trattenere i due blocchi in un ciclo in cui entrambe i contesti
>+aspettano per sempre che l'altro termini. Il validatore è in grado di trovare
>+queste dipendenze cicliche di qualsiasi complessità, ovvero nel mezzo ci
>+potrebbero essere altre sequenze di blocchi. Il validatore troverà se questi
>+blocchi possono essere acquisiti circolarmente.
>+
>+In aggiunta, le seguenti sequenze di blocco nei contesti indicati non sono
>+permesse, indipendentemente da quale che sia la classe di blocco::
>+
>+   <hardirq-safe>   ->  <hardirq-unsafe>
>+   <softirq-safe>   ->  <softirq-unsafe>
>+
>+La prima regola deriva dal fatto che un blocco sicuro in interruzioni può essere
>+trattenuto in un contesto d'interruzione che, per definizione, ha la possibilità
>+di interrompere un blocco insicuro in interruzioni; questo porterebbe ad uno
>+stallo da blocco inverso. La seconda, analogamente, ci dice che un blocco sicuro
>+in interruzioni software potrebbe essere trattenuto in un contesto di
>+interruzione software, dunque potrebbe interrompere un blocco insicuro in
>+interruzioni software.
>+
>+Le suddette regole vengono applicate per qualsiasi sequenza di blocchi: quando
>+si acquisiscono nuovi blocchi, il validatore verifica se vi è una violazione
>+delle regole fra il nuovo blocco e quelli già trattenuti.
>+
>+Quando una classe di blocco cambia stato, applicheremo le seguenti regole:
>+
>+- se viene trovato un nuovo blocco sicuro in interruzioni, verificheremo se
>+  abbia mai trattenuto dei blocchi insicuri in interruzioni.
>+
>+- se viene trovato un nuovo blocco sicuro in interruzioni software,
>+  verificheremo se abbia trattenuto dei blocchi insicuri in interruzioni
>+  software.
>+
>+- se viene trovato un nuovo blocco insicuro in interruzioni, verificheremo se
>+  abbia trattenuto dei blocchi sicuri in interruzioni.
>+
>+- se viene trovato un nuovo blocco insicuro in interruzioni software,
>+  verificheremo se abbia trattenuto dei blocchi sicuri in interruzioni
>+  software.
>+
>+(Di nuovo, questi controlli vengono fatti perché un contesto d'interruzione
>+potrebbe interrompere l'esecuzione di qualsiasi blocco insicuro portando ad uno
>+stallo; questo anche se lo stallo non si verifica in pratica)
>+
>+Eccezione: dipendenze annidate sui dati portano a blocchi annidati
>+------------------------------------------------------------------
>+
>+Ci sono alcuni casi in cui il kernel Linux acquisisce più volte la stessa
>+istanza di una classe di blocco. Solitamente, questo succede quando esiste una
>+gerarchia fra oggetti dello stesso tipo. In questi casi viene ereditato
>+implicitamente l'ordine fra i due oggetti (definito dalle proprietà di questa
>+gerarchia), ed il kernel tratterrà i blocchi in questo ordine prefissato per
>+ognuno degli oggetti.
>+
>+Un esempio di questa gerarchia di oggetti che producono "blocchi annidati" sono
>+i *block-dev* che rappresentano l'intero disco e quelli che rappresentano una
>+sua partizione; la partizione è una parte del disco intero, e l'ordine dei
>+blocchi sarà corretto fintantoche uno acquisisce il blocco del disco intero e
>+poi quello della partizione. Il validatore non rileva automaticamente questo
>+ordine implicito, perché queste regole di sincronizzazione non sono statiche.
>+
>+Per istruire il validatore riguardo a questo uso corretto dei blocchi sono stati
>+introdotte nuove primitive per specificare i "livelli di annidamento". Per
>+esempio, per i blocchi a mutua esclusione dei *block-dev* si avrebbe una
>+chiamata simile a::
>+
>+  enum bdev_bd_mutex_lock_class
>+  {
>+       BD_MUTEX_NORMAL,
>+       BD_MUTEX_WHOLE,
>+       BD_MUTEX_PARTITION
>+  };
>+
>+  mutex_lock_nested(&bdev->bd_contains->bd_mutex, BD_MUTEX_PARTITION);
>+
>+In questo caso la sincronizzazione viene fatta su un *block-dev* sapendo che si
>+tratta di una partizione.
>+
>+Ai fini della validazione, il validatore lo considererà con una - sotto - classe
>+di blocco separata.
>+
>+Nota: Prestate estrema attenzione che la vostra gerarchia sia corretta quando si
>+vogliono usare le primitive _nested(); altrimenti potreste avere sia falsi
>+positivi che falsi negativi.
>+
>+Annotazioni
>+-----------
>+
>+Si possono utilizzare due costrutti per verificare ed annotare se certi blocchi
>+devono essere trattenuti: lockdep_assert_held*(&lock) e
>+lockdep_*pin_lock(&lock).
>+
>+Come suggerito dal nome, la famiglia di macro lockdep_assert_held* asseriscono
>+che un dato blocco in un dato momento deve essere trattenuto (altrimenti, verrà
>+generato un WARN()). Queste vengono usate abbondantemente nel kernel, per
>+esempio in kernel/sched/core.c::
>+
>+  void update_rq_clock(struct rq *rq)
>+  {
>+	s64 delta;
>+
>+	lockdep_assert_held(&rq->lock);
>+	[...]
>+  }
>+
>+dove aver trattenuto rq->lock è necessario per aggiornare in sicurezza il clock
>+rq.
>+
>+L'altra famiglia di macro è lockdep_*pin_lock(), che a dire il vero viene usata
>+solo per rq->lock ATM. Se per caso un blocco non viene trattenuto, queste
>+genereranno un WARN(). Questo si rivela particolarmente utile quando si deve
>+verificare la correttezza di codice con *callback*, dove livelli superiori
>+potrebbero assumere che un blocco rimanga trattenuto, ma livelli inferiori
>+potrebbero invece pensare che il blocco possa essere rilasciato e poi
>+riacquisito (involontariamente si apre una sezione critica). lockdep_pin_lock()
>+restituisce 'struct pin_cookie' che viene usato da lockdep_unpin_lock() per
>+verificare che nessuno abbia manomesso il blocco. Per esempio in
>+kernel/sched/sched.h abbiamo::
>+
>+  static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
>+  {
>+	rf->cookie = lockdep_pin_lock(&rq->lock);
>+	[...]
>+  }
>+
>+  static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
>+  {
>+	[...]
>+	lockdep_unpin_lock(&rq->lock, rf->cookie);
>+  }
>+
>+I commenti riguardo alla sincronizzazione possano fornire informazioni utili,
>+tuttavia sono le verifiche in esecuzione effettuate da queste macro ad essere
>+vitali per scovare problemi di sincronizzazione, ed inoltre forniscono lo stesso
>+livello di informazioni quando si ispeziona il codice. Nel dubbio, preferite
>+queste annotazioni!
>+
>+Dimostrazione di correttezza al 100%
>+------------------------------------
>+
>+Il validatore verifica la proprietà di chiusura in senso matematico. Ovvero, per
>+ogni sequenza di sincronizzazione di un singolo processo che si verifichi almeno
>+una volta nel kernel, il validatore dimostrerà con una certezza del 100% che
>+nessuna combinazione e tempistica di queste sequenze possa causare uno stallo in
>+una qualsiasi classe di blocco. [1]_
>+
>+In pratica, per dimostrare l'esistenza di uno stallo non servono complessi
>+scenari di sincronizzazione multi-processore e multi-processo. Il validatore può
>+dimostrare la correttezza basandosi sulla sola sequenza di sincronizzazione
>+apparsa almeno una volta (in qualunque momento, in qualunque processo o
>+contesto). Uno scenario complesso che avrebbe bisogno di 3 processori e una
>+sfortunata presenza di processi, interruzioni, e pessimo tempismo, può essere
>+riprodotto su un sistema a singolo processore.
>+
>+Questo riduce drasticamente la complessità del controllo di qualità della
>+sincronizzazione nel kernel: quello che deve essere fatto è di innescare nel
>+kernel quante più possibili "semplici" sequenze di sincronizzazione, almeno una
>+volta, allo scopo di dimostrarne la correttezza. Questo al posto di innescare
>+una verifica per ogni possibile combinazione di sincronizzazione fra processori,
>+e differenti scenari con hardirq e softirq e annidamenti vari (nella pratica,
>+impossibile da fare)
>+
>+.. [1]
>+
>+   assumendo che il validatore sia corretto al 100%, e che nessun altra parte
>+   del sistema possa corromperne lo stato. Assumiamo anche che tutti i percorsi
>+   MNI/SMM [potrebbero interrompere anche percorsi dove le interruzioni sono
>+   disabilitate] sono corretti e non interferiscono con il validatore. Inoltre,
>+   assumiamo che un hash a 64-bit sia unico per ogni sequenza di
>+   sincronizzazione nel sistema. Infine, la ricorsione dei blocchi non deve
>+   essere maggiore di 20.
>+
>+Prestazione
>+-----------
>+
>+Le regole sopracitate hanno bisogno di una quantità **enorme** di verifiche
>+durante l'esecuzione. Il sistema sarebbe diventato praticamente inutilizzabile
>+per la sua lentezza se le avessimo fatte davvero per ogni blocco trattenuto e
>+per ogni abilitazione delle interruzioni. La complessità della verifica è
>+O(N^2), quindi avremmo dovuto fare decine di migliaia di verifiche per ogni
>+evento, il tutto per poche centinaia di classi.
>+
>+Il problema è stato risolto facendo una singola verifica per ogni 'scenario di
>+sincronizzazione' (una sequenza unica di blocchi trattenuti uno dopo l'altro).
>+Per farlo, viene mantenuta una pila dei blocchi trattenuti, e viene calcolato un
>+hash a 64-bit unico per ogni sequenza. Quando la sequenza viene verificata per
>+la prima volta, l'hash viene inserito in una tabella hash. La tabella potrà
>+essere verificata senza bisogno di blocchi. Se la sequenza dovesse ripetersi, la
>+tabella ci dirà che non è necessario verificarla nuovamente.
>+
>+Risoluzione dei problemi
>+------------------------
>+
>+Il massimo numero di classi di blocco che il validatore può tracciare è:
>+MAX_LOCKDEP_KEYS. Oltrepassare questo limite indurrà lokdep a generare il
>+seguente avviso::
>+
>+	(DEBUG_LOCKS_WARN_ON(id >= MAX_LOCKDEP_KEYS))
>+
>+Di base questo valore è 8191, e un classico sistema da ufficio ha meno di 1000
>+classi, dunque questo avviso è solitamente la conseguenza di un problema di
>+perdita delle classi di blocco o d'inizializzazione dei blocchi. Di seguito una
>+descrizione dei due problemi:
>+
>+1. caricare e rimuovere continuamente i moduli mentre il validatore è in
>+   esecuzione porterà ad una perdita di classi di blocco. Il problema è che ogni
>+   caricamento crea un nuovo insieme di classi di blocco per tutti i blocchi di
>+   quel modulo. Tuttavia, la rimozione del modulo non rimuove le vecchie classi
>+   (vedi dopo perché non le riusiamo). Dunque, il continuo caricamento e
>+   rimozione di un modulo non fa altro che aumentare il contatore di classi fino
>+   a raggiungere, eventualmente, il limite.
>+
>+2. Usare array con un gran numero di blocchi che non vengono esplicitamente
>+   inizializzati. Per esempio, una tabella hash con 8192 *bucket* dove ognuno ha
>+   il proprio spinlock_t consumerà 8192 classi di blocco a meno che non vengano
>+   esplicitamente inizializzati in esecuzione usando spin_lock_init() invece
>+   dell'inizializzazione durante la compilazione con __SPIN_LOCK_UNLOCKED().
>+   Sbagliare questa inizializzazione garantisce un esaurimento di classi di
>+   blocco. Viceversa, un ciclo che invoca spin_lock_init() su tutti i blocchi li
>+   mapperebbe tutti alla stessa classe di blocco.
>+
>+   La morale della favola è che dovete sempre inizializzare esplicitamente i
>+   vostri blocchi.
>+
>+Qualcuno potrebbe argomentare che il validatore debba permettere il riuso di
>+classi di blocco. Tuttavia, se siete tentati dall'argomento, prima revisionate
>+il codice e pensate alla modifiche necessarie, e tenendo a mente che le classi
>+di blocco da rimuovere probabilmente sono legate al grafo delle dipendenze. Più
>+facile a dirsi che a farsi.
>+
>+Ovviamente, se non esaurite le classi di blocco, la prossima cosa da fare è
>+quella di trovare le classi non funzionanti. Per prima cosa, il seguente comando
>+ritorna il numero di classi attualmente in uso assieme al valore massimo::
>+
>+	grep "lock-classes" /proc/lockdep_stats
>+
>+Questo comando produce il seguente messaggio::
>+
>+	lock-classes:                          748 [max: 8191]
>+
>+Se il numero di assegnazioni (748 qui sopra) aumenta continuamente nel tempo,
>+allora c'è probabilmente un problema da qualche parte. Il seguente comando può
>+essere utilizzato per identificare le classi di blocchi problematiche::
>+
>+	grep "BD" /proc/lockdep
>+
>+Eseguite il comando e salvatene l'output, quindi confrontatelo con l'output di
>+un'esecuzione successiva per identificare eventuali problemi. Questo stesso
>+output può anche aiutarti a trovare situazioni in cui l'inizializzazione del
>+blocco è stata omessa.
>+
>+Lettura ricorsiva dei blocchi
>+-----------------------------
>+
>+Il resto di questo documento vuole dimostrare che certi cicli equivalgono ad una
>+possibilità di stallo.
>+
>+Ci sono tre tipi di bloccatori: gli scrittori (bloccatori esclusivi, come
>+spin_lock() o write_lock()), lettori non ricorsivi (bloccatori condivisi, come
>+down_read()), e lettori ricorsivi (bloccatori condivisi ricorsivi, come
>+rcu_read_lock()). D'ora in poi, per questi tipi di bloccatori, useremo la
>+seguente notazione:
>+
>+    W o E: per gli scrittori (bloccatori esclusivi) (W dall'inglese per
>+           *Writer*, ed E per *Exclusive*).
>+
>+    r: per i lettori non ricorsivi (r dall'inglese per *reader*).
>+
>+    R: per i lettori ricorsivi (R dall'inglese per *Reader*).
>+
>+    S: per qualsiasi lettore (non ricorsivi + ricorsivi), dato che entrambe
>+       sono bloccatori condivisi (S dall'inglese per *Shared*).
>+
>+    N: per gli scrittori ed i lettori non ricorsivi, dato che entrambe sono
>+       non ricorsivi.
>+
>+Ovviamente, N equivale a "r o W" ed S a "r o R".
>+
>+Come suggerisce il nome, i lettori ricorsivi sono dei bloccatori a cui è
>+permesso di acquisire la stessa istanza di blocco anche all'interno della
>+sezione critica di un altro lettore. In altre parole, permette di annidare la
>+stessa istanza di blocco nelle sezioni critiche dei lettori.
>+
>+Dall'altro canto, lo stesso comportamento indurrebbe un lettore non ricorsivo ad
>+auto infliggersi uno stallo.
>+
>+La differenza fra questi due tipi di lettori esiste perché: quelli ricorsivi
>+vengono bloccati solo dal trattenimento di un blocco di scrittura, mentre quelli
>+non ricorsivi possono essere bloccati dall'attesa di un blocco di scrittura.
>+Consideriamo il seguente esempio::
>+
>+    TASK A:            TASK B:
>+
>+    read_lock(X);
>+                       write_lock(X);
>+    read_lock_2(X);
>+
>+L'attività A acquisisce il blocco di lettura X (non importa se di tipo ricorsivo
>+o meno) usando read_lock(). Quando l'attività B tenterà di acquisire il blocco
>+X, si fermerà e rimarrà in attesa che venga rilasciato. Ora se read_lock_2() è
>+un tipo lettore ricorsivo, l'attività A continuerà perché gli scrittori in
>+attesa non possono bloccare lettori ricorsivi, e non avremo alcuno stallo.
>+Tuttavia, se read_lock_2() è un lettore non ricorsivo, allora verrà bloccato
>+dall'attività B e si causerà uno stallo.
>+
>+Condizioni bloccanti per lettori/scrittori su uno stesso blocco
>+---------------------------------------------------------------
>+Essenzialmente ci sono quattro condizioni bloccanti:
>+
>+1. Uno scrittore blocca un altro scrittore.
>+2. Un lettore blocca uno scrittore.
>+3. Uno scrittore blocca sia i lettori ricorsivi che non ricorsivi.
>+4. Un lettore (ricorsivo o meno) non blocca altri lettori ricorsivi ma potrebbe
>+   bloccare quelli non ricorsivi (perché potrebbero esistere degli scrittori in
>+   attesa).
>+
>+Di seguito le tabella delle condizioni bloccanti, Y (*Yes*) significa che il
>+tipo in riga blocca quello in colonna, mentre N l'opposto.
>+
>+    +---+---+---+---+
>+    |   | W | r | R |
>+    +---+---+---+---+
>+    | W | Y | Y | Y |
>+    +---+---+---+---+
>+    | r | Y | Y | N |
>+    +---+---+---+---+
>+    | R | Y | Y | N |
>+    +---+---+---+---+
>+
>+    (W: scrittori, r: lettori non ricorsivi, R: lettori ricorsivi)
>+
>+Al contrario dei blocchi per lettori non ricorsivi, quelli ricorsivi vengono
>+trattenuti da chi trattiene il blocco di scrittura piuttosto che da chi ne
>+attende il rilascio. Per esempio::
>+
>+	TASK A:			TASK B:
>+
>+	read_lock(X);
>+
>+				write_lock(X);
>+
>+	read_lock(X);
>+
>+non produce uno stallo per i lettori ricorsivi, in quanto il processo B rimane
>+in attesta del blocco X, mentre il secondo read_lock() non ha bisogno di
>+aspettare perché si tratta di un lettore ricorsivo. Tuttavia, se read_lock()
>+fosse un lettore non ricorsivo, questo codice produrrebbe uno stallo.
>+
>+Da notare che in funzione dell'operazione di blocco usate per l'acquisizione (in
>+particolare il valore del parametro 'read' in lock_acquire()), un blocco può
>+essere di scrittura (blocco esclusivo), di lettura non ricorsivo (blocco
>+condiviso e non ricorsivo), o di lettura ricorsivo (blocco condiviso e
>+ricorsivo). In altre parole, per un'istanza di blocco esistono tre tipi di
>+acquisizione che dipendono dalla funzione di acquisizione usata: esclusiva, di
>+lettura non ricorsiva, e di lettura ricorsiva.
>+
>+In breve, chiamiamo "non ricorsivi" blocchi di scrittura e quelli di lettura non
>+ricorsiva, mentre "ricorsivi" i blocchi di lettura ricorsivi.
>+
>+I blocchi ricorsivi non si bloccano a vicenda, mentre quelli non ricorsivi sì
>+(anche in lettura). Un blocco di lettura non ricorsivi può bloccare uno
>+ricorsivo, e viceversa.
>+
>+Il seguente esempio mostra uno stallo con blocchi ricorsivi::
>+
>+	TASK A:			TASK B:
>+
>+	read_lock(X);
>+				read_lock(Y);
>+	write_lock(Y);
>+				write_lock(X);
>+
>+Il processo A attende che il processo B esegua read_unlock() so Y, mentre il
>+processo B attende che A esegua read_unlock() su X.
>+
>+Tipi di dipendenze e percorsi forti
>+-----------------------------------
>+Le dipendenze fra blocchi tracciano l'ordine con cui una coppia di blocchi viene
>+acquisita, e perché vi sono 3 tipi di bloccatori, allora avremo 9 tipi di
>+dipendenze. Tuttavia, vi mostreremo che 4 sono sufficienti per individuare gli
>+stalli.
>+
>+Per ogni dipendenza fra blocchi avremo::
>+
>+  L1 -> L2
>+
>+Questo significa che lockdep ha visto acquisire L1 prima di L2 nello stesso
>+contesto di esecuzione. Per quanto riguarda l'individuazione degli stalli, ci
>+interessa sapere se possiamo rimanere bloccati da L2 mentre L1 viene trattenuto.
>+In altre parole, vogliamo sapere se esiste un bloccatore L3 che viene bloccato
>+da L1 e un L2 che viene bloccato da L3. Dunque, siamo interessati a (1) quello
>+che L1 blocca e (2) quello che blocca L2. Di conseguenza, possiamo combinare
>+lettori ricorsivi e non per L1 (perché bloccano gli stessi tipi) e possiamo
>+combinare scrittori e lettori non ricorsivi per L2 (perché vengono bloccati
>+dagli stessi tipi).
>+
>+Con questa semplificazione, possiamo dedurre che ci sono 4 tipi di rami nel
>+grafo delle dipendenze di lockdep:
>+
>+1) -(ER)->:
>+            dipendenza da scrittore esclusivo a lettore ricorsivo. "X -(ER)-> Y"
>+            significa X -> Y, dove X è uno scrittore e Y un lettore ricorsivo.
>+
>+2) -(EN)->:
>+            dipendenza da scrittore esclusivo a bloccatore non ricorsivo.
>+            "X -(EN)->" significa X-> Y, dove X è uno scrittore e Y può essere
>+            o uno scrittore o un lettore non ricorsivo.
>+
>+3) -(SR)->:
>+            dipendenza da lettore condiviso a lettore ricorsivo. "X -(SR)->"
>+            significa X -> Y, dove X è un lettore (ricorsivo o meno) e Y è un
>+            lettore ricorsivo.
>+
>+4) -(SN)->:
>+            dipendenza da lettore condiviso a bloccatore non ricorsivo.
>+            "X -(SN)-> Y" significa X -> Y , dove X è un lettore (ricorsivo
>+            o meno) e Y può essere o uno scrittore o un lettore non ricorsivo.
>+
>+Da notare che presi due blocchi, questi potrebbero avere più dipendenza fra di
>+loro. Per esempio::
>+
>+	TASK A:
>+
>+	read_lock(X);
>+	write_lock(Y);
>+	...
>+
>+	TASK B:
>+
>+	write_lock(X);
>+	write_lock(Y);
>+
>+Nel grafo delle dipendenze avremo sia X -(SN)-> Y che X -(EN)-> Y.
>+
>+Usiamo -(xN)-> per rappresentare i rami sia per -(EN)-> che -(SN)->, allo stesso
>+modo -(Ex)->, -(xR)-> e -(Sx)->
>+
>+Un "percorso" in un grafo è una serie di nodi e degli archi che li congiungono.
>+Definiamo un percorso "forte", come il percorso che non ha archi (dipendenze) di
>+tipo -(xR)-> e -(Sx)->. In altre parole, un percorso "forte" è un percorso da un
>+blocco ad un altro attraverso le varie dipendenze, e se sul percorso abbiamo X
>+-> Y -> Z (dove X, Y, e Z sono blocchi), e da X a Y si ha una dipendenza -(SR)->
>+o -(ER)->, allora fra Y e Z non deve esserci una dipendenza -(SN)-> o -(SR)->.
>+
>+Nella prossima sezione vedremo perché definiamo questo percorso "forte".
>+
>+Identificazione di stalli da lettura ricorsiva
>+----------------------------------------------
>+Ora vogliamo dimostrare altre due cose:
>+
>+Lemma 1:
>+
>+Se esiste un percorso chiuso forte (ciclo forte), allora esiste anche una
>+combinazione di sequenze di blocchi che causa uno stallo. In altre parole,
>+l'esistenza di un ciclo forte è sufficiente alla scoperta di uno stallo.
>+
>+Lemma 2:
>+
>+Se non esiste un percorso chiuso forte (ciclo forte), allora non esiste una
>+combinazione di sequenze di blocchi che causino uno stallo. In altre parole, i
>+cicli forti sono necessari alla rilevazione degli stallo.
>+
>+Con questi due lemmi possiamo facilmente affermare che un percorso chiuso forte
>+è sia sufficiente che necessario per avere gli stalli, dunque averli equivale
>+alla possibilità di imbattersi concretamente in uno stallo. Un percorso chiuso
>+forte significa che può causare stalli, per questo lo definiamo "forte", ma ci
>+sono anche cicli di dipendenze che non causeranno stalli.
>+
>+Dimostrazione di sufficienza (lemma 1):
>+
>+Immaginiamo d'avere un ciclo forte::
>+
>+    L1 -> L2 ... -> Ln -> L1
>+
>+Questo significa che abbiamo le seguenti dipendenze::
>+
>+    L1   -> L2
>+    L2   -> L3
>+    ...
>+    Ln-1 -> Ln
>+    Ln   -> L1
>+
>+Ora possiamo costruire una combinazione di sequenze di blocchi che causano lo
>+stallo.
>+
>+Per prima cosa facciamo sì che un processo/processore prenda L1 in L1 -> L2, poi
>+un altro prende L2 in L2 -> L3, e così via. Alla fine, tutti i Lx in Lx -> Lx+1
>+saranno trattenuti da processi/processori diversi.
>+
>+Poi visto che abbiamo L1 -> L2, chi trattiene L1 vorrà acquisire L2 in L1 -> L2,
>+ma prima dovrà attendere che venga rilasciato da chi lo trattiene. Questo perché
>+L2 è già trattenuto da un altro processo/processore, ed in più L1 -> L2 e L2 ->
>+L3 non sono -(xR)-> né -(Sx)-> (la definizione di forte). Questo significa che L2
>+in L1 -> L2 non è un bloccatore non ricorsivo (bloccabile da chiunque), e L2 in
>+L2 -> L3 non è uno scrittore (che blocca chiunque).
>+
>+In aggiunta, possiamo trarre una simile conclusione per chi sta trattenendo L2:
>+deve aspettare che L3 venga rilasciato, e così via. Ora possiamo dimostrare che
>+chi trattiene Lx deve aspettare che Lx+1 venga rilasciato. Notiamo che Ln+1 è
>+L1, dunque si è creato un ciclo dal quale non possiamo uscire, quindi si ha uno
>+stallo.
>+
>+Dimostrazione della necessità (lemma 2):
>+
>+Questo lemma equivale a dire che: se siamo in uno scenario di stallo, allora
>+deve esiste un ciclo forte nel grafo delle dipendenze.
>+
>+Secondo Wikipedia[1], se c'è uno stallo, allora deve esserci un ciclo di attese,
>+ovvero ci sono N processi/processori dove P1 aspetta un blocco trattenuto da P2,
>+e P2 ne aspetta uno trattenuto da P3, ... e Pn attende che il blocco P1 venga
>+rilasciato. Chiamiamo Lx il blocco che attende Px, quindi P1 aspetta L1 e
>+trattiene Ln. Quindi avremo Ln -> L1 nel grafo delle dipendenze. Similarmente,
>+nel grafo delle dipendenze avremo L1 -> L2, L2 -> L3, ..., Ln-1 -> Ln, il che
>+significa che abbiamo un ciclo::
>+
>+	Ln -> L1 -> L2 -> ... -> Ln
>+
>+, ed ora dimostriamo d'avere un ciclo forte.
>+
>+Per un blocco Lx, il processo Px contribuisce alla dipendenza Lx-1 -> Lx e Px+1
>+contribuisce a quella Lx -> Lx+1. Visto che Px aspetta che Px+1 rilasci Lx, sarà
>+impossibile che Lx in Px+1 sia un lettore e che Lx in Px sia un lettore
>+ricorsivo. Questo perché i lettori (ricorsivi o meno) non bloccano lettori
>+ricorsivi. Dunque, Lx-1 -> Lx e Lx -> Lx+1 non possono essere una coppia di
>+-(xR)-> -(Sx)->. Questo è vero per ogni ciclo, dunque, questo è un ciclo forte.
>+
>+Riferimenti
>+-----------
>+
>+[1]: https://it.wikipedia.org/wiki/Stallo_(informatica)
>+
>+[2]: Shibu, K. (2009). Intro To Embedded Systems (1st ed.). Tata McGraw-Hill
>diff --git a/Documentation/translations/it_IT/locking/lockstat.rst b/Documentation/translations/it_IT/locking/lockstat.rst
>new file mode 100644
>index 000000000000..77972d971d7c
>--- /dev/null
>+++ b/Documentation/translations/it_IT/locking/lockstat.rst
>@@ -0,0 +1,230 @@
>+.. SPDX-License-Identifier: GPL-2.0
>+
>+.. include:: ../disclaimer-ita.rst
>+
>+=======================
>+Statistiche sui blocchi
>+=======================
>+
>+Cosa
>+====
>+
>+Come suggerisce il nome, fornisce statistiche sui blocchi.
>+
>+
>+Perché
>+======
>+
>+Perché, tanto per fare un esempio, le contese sui blocchi possono influenzare
>+significativamente le prestazioni.
>+
>+Come
>+====
>+
>+*Lockdep* ha punti di collegamento nelle funzioni di blocco e inoltre
>+mappa le istanze di blocco con le relative classi. Partiamo da questo punto
>+(vedere Documentation/translations/it_IT/locking/lockdep-design.rst).
>+Il grafico sottostante mostra la relazione che intercorre fra le
>+funzioni di blocco e i vari punti di collegamenti che ci sono al loro
>+interno::
>+
>+        __acquire
>+            |
>+           lock _____
>+            |        \
>+            |    __contended
>+            |         |
>+            |       <wait>
>+            | _______/
>+            |/
>+            |
>+       __acquired
>+            |
>+            .
>+          <hold>
>+            .
>+            |
>+       __release
>+            |
>+         unlock
>+
>+  lock, unlock	- le classiche funzioni di blocco
>+  __*		- i punti di collegamento
>+  <> 		- stati
>+
>+Grazie a questi punti di collegamento possiamo fornire le seguenti statistiche:
>+
>+con-bounces
>+  - numero di contese su un blocco che riguarda dati di un processore
>+
>+contentions
>+  - numero di acquisizioni di blocchi che hanno dovuto attendere
>+
>+wait time
>+  min
>+    - tempo minimo (diverso da zero) che sia mai stato speso in attesa di
>+      un blocco
>+
>+  max
>+    - tempo massimo che sia mai stato speso in attesa di un blocco
>+
>+  total
>+    - tempo totale speso in attesa di un blocco
>+
>+  avg
>+	- tempo medio speso in attesa di un blocco
>+
>+acq-bounces
>+  - numero di acquisizioni di blocco che riguardavano i dati su un processore
>+
>+acquisitions
>+  - numero di volte che un blocco è stato ottenuto
>+
>+hold time
>+  min
>+    - tempo minimo (diverso da zero) che sia mai stato speso trattenendo un blocco
>+
>+  max
>+    - tempo massimo che sia mai stato speso trattenendo un blocco
>+
>+  total
>+    - tempo totale di trattenimento di un blocco
>+
>+  avg
>+    - tempo medio di trattenimento di un blocco
>+
>+Questi numeri vengono raccolti per classe di blocco, e per ogni stato di
>+lettura/scrittura (quando applicabile).
>+
>+Inoltre, questa raccolta di statistiche tiene traccia di 4 punti di contesa
>+per classe di blocco. Un punto di contesa è una chiamata che ha dovuto
>+aspettare l'acquisizione di un blocco.
>+
>+Configurazione
>+--------------
>+
>+Le statistiche sui blocchi si abilitano usando l'opzione di configurazione
>+CONFIG_LOCK_STAT.
>+
>+Uso
>+---
>+
>+Abilitare la raccolta di statistiche::
>+
>+	# echo 1 >/proc/sys/kernel/lock_stat
>+
>+Disabilitare la raccolta di statistiche::
>+
>+	# echo 0 >/proc/sys/kernel/lock_stat
>+
>+Per vedere le statistiche correnti sui blocchi::
>+
>+  ( i numeri di riga non fanno parte dell'output del comando, ma sono stati
>+  aggiunti ai fini di questa spiegazione )
>+
>+  # less /proc/lock_stat
>+
>+  01 lock_stat version 0.4
>+  02-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>+  03                              class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
>+  04-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>+  05
>+  06                         &mm->mmap_sem-W:            46             84           0.26         939.10       16371.53         194.90          47291        2922365           0.16     2220301.69 17464026916.32        5975.99
>+  07                         &mm->mmap_sem-R:            37            100           1.31      299502.61      325629.52        3256.30         212344       34316685           0.10        7744.91    95016910.20           2.77
>+  08                         ---------------
>+  09                           &mm->mmap_sem              1          [<ffffffff811502a7>] khugepaged_scan_mm_slot+0x57/0x280
>+  10                           &mm->mmap_sem             96          [<ffffffff815351c4>] __do_page_fault+0x1d4/0x510
>+  11                           &mm->mmap_sem             34          [<ffffffff81113d77>] vm_mmap_pgoff+0x87/0xd0
>+  12                           &mm->mmap_sem             17          [<ffffffff81127e71>] vm_munmap+0x41/0x80
>+  13                         ---------------
>+  14                           &mm->mmap_sem              1          [<ffffffff81046fda>] dup_mmap+0x2a/0x3f0
>+  15                           &mm->mmap_sem             60          [<ffffffff81129e29>] SyS_mprotect+0xe9/0x250
>+  16                           &mm->mmap_sem             41          [<ffffffff815351c4>] __do_page_fault+0x1d4/0x510
>+  17                           &mm->mmap_sem             68          [<ffffffff81113d77>] vm_mmap_pgoff+0x87/0xd0
>+  18
>+  19.............................................................................................................................................................................................................................
>+  20
>+  21                         unix_table_lock:           110            112           0.21          49.24         163.91           1.46          21094          66312           0.12         624.42       31589.81           0.48
>+  22                         ---------------
>+  23                         unix_table_lock             45          [<ffffffff8150ad8e>] unix_create1+0x16e/0x1b0
>+  24                         unix_table_lock             47          [<ffffffff8150b111>] unix_release_sock+0x31/0x250
>+  25                         unix_table_lock             15          [<ffffffff8150ca37>] unix_find_other+0x117/0x230
>+  26                         unix_table_lock              5          [<ffffffff8150a09f>] unix_autobind+0x11f/0x1b0
>+  27                         ---------------
>+  28                         unix_table_lock             39          [<ffffffff8150b111>] unix_release_sock+0x31/0x250
>+  29                         unix_table_lock             49          [<ffffffff8150ad8e>] unix_create1+0x16e/0x1b0
>+  30                         unix_table_lock             20          [<ffffffff8150ca37>] unix_find_other+0x117/0x230
>+  31                         unix_table_lock              4          [<ffffffff8150a09f>] unix_autobind+0x11f/0x1b0
>+
>+Questo estratto mostra le statistiche delle prime due classi di
>+blocco. La riga 01 mostra la versione dell'output - la versione
>+cambierà ogni volta che cambia il formato. Le righe dalla 02 alla 04
>+rappresentano l'intestazione con la descrizione delle colonne. Le
>+statistiche sono mostrate nelle righe dalla 05 alla 18 e dalla 20
>+alla 31. Queste statistiche sono divise in due parti: le statistiche,
>+seguite dai punti di contesa (righe 08 e 13) separati da un divisore.
>+
>+Le righe dalla 09 alla 12 mostrano i primi quattro punti di contesa
>+registrati (il codice che tenta di acquisire un blocco) e le righe
>+dalla 14 alla 17 mostrano i primi quattro punti contesi registrati
>+(ovvero codice che ha acquisito un blocco). È possibile che nelle
>+statistiche manchi il valore *max con-bounces*.
>+
>+Il primo blocco (righe dalla 05 alla 18) è di tipo lettura/scrittura e quindi
>+mostra due righe prima del divisore. I punti di contesa non corrispondono alla
>+descrizione delle colonne nell'intestazione; essi hanno due colonne: *punti di
>+contesa* e *[<IP>] simboli*. Il secondo gruppo di punti di contesa sono i punti
>+con cui si contende il blocco.
>+
>+La parte interna del tempo è espressa in us (microsecondi).
>+
>+Quando si ha a che fare con blocchi annidati si potrebbero vedere le
>+sottoclassi di blocco::
>+
>+  32...........................................................................................................................................................................................................................
>+  33
>+  34                               &rq->lock:       13128          13128           0.43         190.53      103881.26           7.91          97454        3453404           0.00         401.11    13224683.11           3.82
>+  35                               ---------
>+  36                               &rq->lock          645          [<ffffffff8103bfc4>] task_rq_lock+0x43/0x75
>+  37                               &rq->lock          297          [<ffffffff8104ba65>] try_to_wake_up+0x127/0x25a
>+  38                               &rq->lock          360          [<ffffffff8103c4c5>] select_task_rq_fair+0x1f0/0x74a
>+  39                               &rq->lock          428          [<ffffffff81045f98>] scheduler_tick+0x46/0x1fb
>+  40                               ---------
>+  41                               &rq->lock           77          [<ffffffff8103bfc4>] task_rq_lock+0x43/0x75
>+  42                               &rq->lock          174          [<ffffffff8104ba65>] try_to_wake_up+0x127/0x25a
>+  43                               &rq->lock         4715          [<ffffffff8103ed4b>] double_rq_lock+0x42/0x54
>+  44                               &rq->lock          893          [<ffffffff81340524>] schedule+0x157/0x7b8
>+  45
>+  46...........................................................................................................................................................................................................................
>+  47
>+  48                             &rq->lock/1:        1526          11488           0.33         388.73      136294.31          11.86          21461          38404           0.00          37.93      109388.53           2.84
>+  49                             -----------
>+  50                             &rq->lock/1        11526          [<ffffffff8103ed58>] double_rq_lock+0x4f/0x54
>+  51                             -----------
>+  52                             &rq->lock/1         5645          [<ffffffff8103ed4b>] double_rq_lock+0x42/0x54
>+  53                             &rq->lock/1         1224          [<ffffffff81340524>] schedule+0x157/0x7b8
>+  54                             &rq->lock/1         4336          [<ffffffff8103ed58>] double_rq_lock+0x4f/0x54
>+  55                             &rq->lock/1          181          [<ffffffff8104ba65>] try_to_wake_up+0x127/0x25a
>+
>+La riga 48 mostra le statistiche per la seconda sottoclasse (/1) della
>+classe *&irq->lock* (le sottoclassi partono da 0); in questo caso,
>+come suggerito dalla riga 50, ``double_rq_lock`` tenta di acquisire un blocco
>+annidato di due spinlock.
>+
>+Per vedere i blocco più contesi::
>+
>+  # grep : /proc/lock_stat | head
>+			clockevents_lock:       2926159        2947636           0.15       46882.81  1784540466.34         605.41        3381345        3879161           0.00        2260.97    53178395.68          13.71
>+		     tick_broadcast_lock:        346460         346717           0.18        2257.43    39364622.71         113.54        3642919        4242696           0.00        2263.79    49173646.60          11.59
>+		  &mapping->i_mmap_mutex:        203896         203899           3.36      645530.05 31767507988.39      155800.21        3361776        8893984           0.17        2254.15    14110121.02           1.59
>+			       &rq->lock:        135014         136909           0.18         606.09      842160.68           6.15        1540728       10436146           0.00         728.72    17606683.41           1.69
>+	       &(&zone->lru_lock)->rlock:         93000          94934           0.16          59.18      188253.78           1.98        1199912        3809894           0.15         391.40     3559518.81           0.93
>+			 tasklist_lock-W:         40667          41130           0.23        1189.42      428980.51          10.43         270278         510106           0.16         653.51     3939674.91           7.72
>+			 tasklist_lock-R:         21298          21305           0.20        1310.05      215511.12          10.12         186204         241258           0.14        1162.33     1179779.23           4.89
>+			      rcu_node_1:         47656          49022           0.16         635.41      193616.41           3.95         844888        1865423           0.00         764.26     1656226.96           0.89
>+       &(&dentry->d_lockref.lock)->rlock:         39791          40179           0.15        1302.08       88851.96           2.21        2790851       12527025           0.10        1910.75     3379714.27           0.27
>+			      rcu_node_0:         29203          30064           0.16         786.55     1555573.00          51.74          88963         244254           0.00         398.87      428872.51           1.76
>+
>+Per cancellare le statistiche::
>+
>+  # echo 0 > /proc/lock_stat
>diff --git a/Documentation/translations/it_IT/locking/locktorture.rst b/Documentation/translations/it_IT/locking/locktorture.rst
>new file mode 100644
>index 000000000000..87a0dbeaca77
>--- /dev/null
>+++ b/Documentation/translations/it_IT/locking/locktorture.rst
>@@ -0,0 +1,181 @@
>+.. SPDX-License-Identifier: GPL-2.0
>+
>+.. include:: ../disclaimer-ita.rst
>+
>+============================================
>+Funzionamento del test *Kernel Lock Torture*
>+============================================
>+
>+CONFIG_LOCK_TORTURE_TEST
>+========================
>+
>+L'opzione di configurazione CONFIG_LOCK_TORTURE_TEST fornisce un
>+modulo kernel che esegue delle verifiche che *torturano* le primitive di
>+sincronizzazione del kernel. Se dovesse servire, il modulo kernel,
>+'locktorture', può essere generato successivamente su un kernel che
>+volete verificare. Periodicamente le verifiche stampano messaggi tramite
>+``printk()`` e che quindi possono essere letti tramite ``dmesg`` (magari
>+filtrate l'output con ``grep "torture"``). La verifica inizia quando
>+il modulo viene caricato e termina quando viene rimosso. Questo
>+programma si basa sulle modalità di verifica di RCU tramite rcutorture.
>+
>+Questa verifica consiste nella creazione di un certo numero di thread
>+del kernel che acquisiscono un blocco e lo trattengono per una certa
>+quantità di tempo così da simulare diversi comportamenti nelle sezioni
>+critiche. La quantità di contese su un blocco può essere simulata
>+allargando la sezione critica e/o creando più thread.
>+
>+
>+Parametri del modulo
>+====================
>+
>+Questo modulo ha i seguenti parametri:
>+
>+
>+Specifici di locktorture
>+------------------------
>+
>+nwriters_stress
>+		  Numero di thread del kernel che stresseranno l'acquisizione
>+		  esclusiva dei blocchi (scrittori). Il valore di base è il
>+		  doppio del numero di processori attivi presenti.
>+
>+nreaders_stress
>+		  Numero di thread del kernel che stresseranno l'acquisizione
>+		  condivisa dei blocchi (lettori). Il valore di base è lo stesso
>+		  di nwriters_stress. Se l'utente non ha specificato
>+		  nwriters_stress, allora entrambe i valori corrisponderanno
>+		  al numero di processori attivi presenti.
>+
>+torture_type
>+		  Tipo di blocco da verificare. Di base, solo gli spinlock
>+		  verranno verificati. Questo modulo può verificare anche
>+		  i seguenti tipi di blocchi:
>+
>+		     - "lock_busted":
>+				Simula un'incorretta implementazione del
>+				blocco.
>+
>+		     - "spin_lock":
>+				coppie di spin_lock() e spin_unlock().
>+
>+		     - "spin_lock_irq":
>+				coppie di spin_lock_irq() e spin_unlock_irq().
>+
>+		     - "rw_lock":
>+				coppie di rwlock read/write lock() e unlock().
>+
>+		     - "rw_lock_irq":
>+				copie di rwlock read/write lock_irq() e
>+				unlock_irq().
>+
>+		     - "mutex_lock":
>+				coppie di mutex_lock() e mutex_unlock().
>+
>+		     - "rtmutex_lock":
>+				coppie di rtmutex_lock() e rtmutex_unlock().
>+				Il kernel deve avere CONFIG_RT_MUTEXES=y.
>+
>+		     - "rwsem_lock":
>+				coppie di semafori read/write down() e up().
>+
>+
>+Generici dell'ambiente di sviluppo 'torture' (RCU + locking)
>+------------------------------------------------------------
>+
>+shutdown_secs
>+		  Numero di secondi prima che la verifica termini e il sistema
>+		  venga spento.  Il valore di base è zero, il che disabilita
>+		  la possibilità di terminare e spegnere. Questa funzionalità
>+		  può essere utile per verifiche automatizzate.
>+
>+onoff_interval
>+		  Numero di secondi fra ogni tentativo di esecuzione di
>+		  un'operazione casuale di CPU-hotplug. Di base è zero, il
>+		  che disabilita la funzionalità di CPU-hotplug. Nei kernel
>+		  con CONFIG_HOTPLUG_CPU=n, locktorture si rifiuterà, senza
>+		  dirlo, di effettuare una qualsiasi operazione di
>+		  CPU-hotplug indipendentemente dal valore specificato in
>+		  onoff_interval.
>+
>+onoff_holdoff
>+		  Numero di secondi da aspettare prima di iniziare le
>+		  operazioni di CPU-hotplug.  Normalmente questo verrebbe
>+		  usato solamente quando locktorture è compilato come parte
>+		  integrante del kernel ed eseguito automaticamente all'avvio,
>+		  in questo caso è utile perché permette di non confondere
>+		  l'avvio con i processori che vanno e vengono. Questo
>+		  parametro è utile sono se CONFIG_HOTPLUG_CPU è abilitato.
>+
>+stat_interval
>+		  Numero di secondi fra una stampa (printk()) delle
>+		  statistiche e l'altra. Di base, locktorture riporta le
>+		  statistiche ogni 60 secondi. Impostando l'intervallo a 0
>+		  ha l'effetto di stampare le statistiche -solo- quando il
>+		  modulo viene rimosso.
>+
>+stutter
>+		  Durata della verifica prima di effettuare una pausa di
>+		  eguale durata. Di base "stutter=5", quindi si eseguono
>+		  verifiche e pause di (circa) cinque secondi.
>+		  L'impostazione di "stutter=0" fa si che la verifica
>+		  venga eseguita continuamente senza fermarsi.
>+
>+shuffle_interval
>+		  Il numero di secondi per cui un thread debba mantenere
>+		  l'affinità con un sottoinsieme di processori, di base è
>+		  3 secondi. Viene usato assieme a test_no_idle_hz.
>+
>+verbose
>+		  Abilita le stampe di debug, via printk(). Di base è
>+		  abilitato. Queste informazioni aggiuntive sono per la
>+		  maggior parte relative ad errori di alto livello e resoconti
>+		  da parte dell'struttura 'torture'.
>+
>+
>+Statistiche
>+===========
>+
>+Le statistiche vengono stampate secondo il seguente formato::
>+
>+  spin_lock-torture: Writes:  Total: 93746064  Max/Min: 0/0   Fail: 0
>+     (A)		    (B)		   (C)		  (D)	       (E)
>+
>+  (A): tipo di lock sotto verifica -- parametro torture_type.
>+
>+  (B): Numero di acquisizione del blocco in scrittura. Se si ha a che fare
>+       con una primitiva di lettura/scrittura apparirà di seguito anche una
>+       seconda voce "Reads"
>+
>+  (C): Numero di volte che il blocco è stato acquisito
>+
>+  (D): Numero minimo e massimo di volte che un thread ha fallito
>+       nell'acquisire il blocco
>+
>+  (E): valori true/false nel caso di errori durante l'acquisizione del blocco.
>+       Questo dovrebbe dare un riscontro positivo -solo- se c'è un baco
>+       nell'implementazione delle primitive di sincronizzazione. Altrimenti un
>+       blocco non dovrebbe mai fallire (per esempio, spin_lock()).
>+       Ovviamente lo stesso si applica per (C). Un semplice esempio è il tipo
>+       "lock_busted".
>+
>+Uso
>+===
>+
>+Il seguente script può essere utilizzato per verificare i blocchi::
>+
>+	#!/bin/sh
>+
>+	modprobe locktorture
>+	sleep 3600
>+	rmmod locktorture
>+	dmesg | grep torture:
>+
>+L'output può essere manualmente ispezionato cercando il marcatore d'errore
>+"!!!". Ovviamente potreste voler creare degli script più elaborati che
>+verificano automaticamente la presenza di errori. Il comando "rmmod" forza la
>+stampa (usando printk()) di "SUCCESS", "FAILURE", oppure "RCU_HOTPLUG". I primi
>+due si piegano da soli, mentre l'ultimo indica che non stati trovati problemi di
>+sincronizzazione, tuttavia ne sono stati trovati in CPU-hotplug.
>+
>+Consultate anche: Documentation/translations/it_IT/RCU/torture.rst
>diff --git a/Documentation/translations/it_IT/locking/locktypes.rst b/Documentation/translations/it_IT/locking/locktypes.rst
>new file mode 100644
>index 000000000000..1c7056283b9d
>--- /dev/null
>+++ b/Documentation/translations/it_IT/locking/locktypes.rst
>@@ -0,0 +1,547 @@
>+.. SPDX-License-Identifier: GPL-2.0
>+
>+.. include:: ../disclaimer-ita.rst
>+
>+.. _it_kernel_hacking_locktypes:
>+
>+========================================
>+Tipologie di blocco e le loro istruzioni
>+========================================
>+
>+Introduzione
>+============
>+
>+Il kernel fornisce un certo numero di primitive di blocco che possiamo dividere
>+in tre categorie:
>+
>+  - blocchi ad attesa con sospensione
>+  - blocchi locali per CPU
>+  - blocchi ad attesa attiva
>+
>+Questo documento descrive questi tre tipi e fornisce istruzioni su come
>+annidarli, ed usarli su kernel PREEMPT_RT.
>+
>+Categorie di blocchi
>+====================
>+
>+Blocchi ad attesa con sospensione
>+---------------------------------
>+
>+I blocchi ad attesa con sospensione possono essere acquisiti solo in un contesti
>+dov'è possibile la prelazione.
>+
>+Diverse implementazioni permettono di usare try_lock() anche in altri contesti,
>+nonostante ciò è bene considerare anche la sicurezza dei corrispondenti
>+unlock(). Inoltre, vanno prese in considerazione anche le varianti di *debug*
>+di queste primitive. Insomma, non usate i blocchi ad attesa con sospensioni in
>+altri contesti a meno che proprio non vi siano alternative.
>+
>+In questa categoria troviamo:
>+
>+ - mutex
>+ - rt_mutex
>+ - semaphore
>+ - rw_semaphore
>+ - ww_mutex
>+ - percpu_rw_semaphore
>+
>+Nei kernel con PREEMPT_RT, i seguenti blocchi sono convertiti in blocchi ad
>+attesa con sospensione:
>+
>+ - local_lock
>+ - spinlock_t
>+ - rwlock_t
>+
>+Blocchi locali per CPU
>+----------------------
>+
>+ - local_lock
>+
>+Su kernel non-PREEMPT_RT, le funzioni local_lock gestiscono le primitive di
>+disabilitazione di prelazione ed interruzioni. Al contrario di altri meccanismi,
>+la disabilitazione della prelazione o delle interruzioni sono puri meccanismi
>+per il controllo della concorrenza su una CPU e quindi non sono adatti per la
>+gestione della concorrenza inter-CPU.
>+
>+Blocchi ad attesa attiva
>+------------------------
>+
>+ - raw_spinlcok_t
>+ - bit spinlocks
>+
>+ Nei kernel non-PREEMPT_RT, i seguenti blocchi sono ad attesa attiva:
>+
>+ - spinlock_t
>+ - rwlock_t
>+
>+Implicitamente, i blocchi ad attesa attiva disabilitano la prelazione e le
>+funzioni lock/unlock hanno anche dei suffissi per gestire il livello di
>+protezione:
>+
>+ ===================  =========================================================================
>+ _bh()                disabilita / abilita  *bottom halves* (interruzioni software)
>+ _irq()               disabilita / abilita le interruzioni
>+ _irqsave/restore()   salva e disabilita le interruzioni / ripristina ed attiva le interruzioni
>+ ===================  =========================================================================
>+
>+Semantica del proprietario
>+==========================
>+
>+Eccetto i semafori, i sopracitati tipi di blocchi hanno tutti una semantica
>+molto stringente riguardo al proprietario di un blocco:
>+
>+  Il contesto (attività) che ha acquisito il blocco deve rilasciarlo
>+
>+I semafori rw_semaphores hanno un'interfaccia speciale che permette anche ai non
>+proprietari del blocco di rilasciarlo per i lettori.
>+
>+rtmutex
>+=======
>+
>+I blocchi a mutua esclusione RT (*rtmutex*) sono un sistema a mutua esclusione
>+con supporto all'ereditarietà della priorità (PI).
>+
>+Questo meccanismo ha delle limitazioni sui kernel non-PREEMPT_RT dovuti alla
>+prelazione e alle sezioni con interruzioni disabilitate.
>+
>+Chiaramente, questo meccanismo non può avvalersi della prelazione su una sezione
>+dove la prelazione o le interruzioni sono disabilitate; anche sui kernel
>+PREEMPT_RT. Tuttavia, i kernel PREEMPT_RT eseguono la maggior parte delle
>+sezioni in contesti dov'è possibile la prelazione, specialmente in contesti
>+d'interruzione (anche software). Questa conversione permette a spinlock_t e
>+rwlock_t di essere implementati usando rtmutex.
>+
>+semaphore
>+=========
>+
>+La primitiva semaphore implementa un semaforo con contatore.
>+
>+I semafori vengono spesso utilizzati per la serializzazione e l'attesa, ma per
>+nuovi casi d'uso si dovrebbero usare meccanismi diversi, come mutex e
>+completion.
>+
>+semaphore e PREEMPT_RT
>+----------------------
>+
>+I kernel PREEMPT_RT non cambiano l'implementazione di semaphore perché non hanno
>+un concetto di proprietario, dunque impediscono a PREEMPT_RT d'avere
>+l'ereditarietà della priorità sui semafori. Un proprietario sconosciuto non può
>+ottenere una priorità superiore. Di consequenza, bloccarsi sui semafori porta
>+all'inversione di priorità.
>+
>+
>+rw_semaphore
>+============
>+
>+Il blocco rw_semaphore è un meccanismo che permette più lettori ma un solo scrittore.
>+
>+Sui kernel non-PREEMPT_RT l'implementazione è imparziale, quindi previene
>+l'inedia dei processi scrittori.
>+
>+Questi blocchi hanno una semantica molto stringente riguardo il proprietario, ma
>+offre anche interfacce speciali che permettono ai processi non proprietari di
>+rilasciare un processo lettore. Queste interfacce funzionano indipendentemente
>+dalla configurazione del kernel.
>+
>+rw_semaphore e PREEMPT_RT
>+-------------------------
>+
>+I kernel PREEMPT_RT sostituiscono i rw_semaphore con un'implementazione basata
>+su rt_mutex, e questo ne modifica l'imparzialità:
>+
>+ Dato che uno scrittore rw_semaphore non può assicurare la propria priorità ai
>+ suoi lettori, un lettore con priorità più bassa che ha subito la prelazione
>+ continuerà a trattenere il blocco, quindi porta all'inedia anche gli scrittori
>+ con priorità più alta. Per contro, dato che i lettori possono garantire la
>+ propria priorità agli scrittori, uno scrittore a bassa priorità che subisce la
>+ prelazione vedrà la propria priorità alzata finché non rilascerà il blocco, e
>+ questo preverrà l'inedia dei processi lettori a causa di uno scrittore.
>+
>+
>+local_lock
>+==========
>+
>+I local_lock forniscono nomi agli ambiti di visibilità delle sezioni critiche
>+protette tramite la disattivazione della prelazione o delle interruzioni.
>+
>+Sui kernel non-PREEMPT_RT le operazioni local_lock si traducono
>+nell'abilitazione o disabilitazione della prelazione o le interruzioni.
>+
>+ ===============================  ======================
>+ local_lock(&llock)               preempt_disable()
>+ local_unlock(&llock)             preempt_enable()
>+ local_lock_irq(&llock)           local_irq_disable()
>+ local_unlock_irq(&llock)         local_irq_enable()
>+ local_lock_irqsave(&llock)       local_irq_save()
>+ local_unlock_irqrestore(&llock)  local_irq_restore()
>+ ===============================  ======================
>+
>+Gli ambiti di visibilità con nome hanno due vantaggi rispetto alle primitive di
>+base:
>+
>+  - Il nome del blocco permette di fare un'analisi statica, ed è anche chiaro su
>+    cosa si applichi la protezione cosa che invece non si può fare con le
>+    classiche primitive in quanto sono opache e senza alcun ambito di
>+    visibilità.
>+
>+  - Se viene abilitato lockdep, allora local_lock ottiene un lockmap che
>+    permette di verificare la bontà della protezione. Per esempio, questo può
>+    identificare i casi dove una funzione usa preempt_disable() come meccanismo
>+    di protezione in un contesto d'interruzione (anche software). A parte
>+    questo, lockdep_assert_held(&llock) funziona come tutte le altre primitive
>+    di sincronizzazione.
>+
>+local_lock e PREEMPT_RT
>+-------------------------
>+
>+I kernel PREEMPT_RT sostituiscono local_lock con uno spinlock_t per CPU, quindi
>+ne cambia la semantica:
>+
>+  - Tutte le modifiche a spinlock_t si applicano anche a local_lock
>+
>+L'uso di local_lock
>+-------------------
>+
>+I local_lock dovrebbero essere usati su kernel non-PREEMPT_RT quando la
>+disabilitazione della prelazione o delle interruzioni è il modo più adeguato per
>+gestire l'accesso concorrente a strutture dati per CPU.
>+
>+Questo meccanismo non è adatto alla protezione da prelazione o interruzione su
>+kernel PREEMPT_RT dato che verrà convertito in spinlock_t.
>+
>+
>+raw_spinlock_t e spinlock_t
>+===========================
>+
>+raw_spinlock_t
>+--------------
>+
>+I blocco raw_spinlock_t è un blocco ad attesa attiva su tutti i tipi di kernel,
>+incluso quello PREEMPT_RT. Usate raw_spinlock_t solo in sezioni critiche nel
>+cuore del codice, nella gestione delle interruzioni di basso livello, e in posti
>+dove è necessario disabilitare la prelazione o le interruzioni. Per esempio, per
>+accedere in modo sicuro lo stato dell'hardware. A volte, i raw_spinlock_t
>+possono essere usati quando la sezione critica è minuscola, per evitare gli
>+eccessi di un rtmutex.
>+
>+spinlock_t
>+----------
>+
>+Il significato di spinlock_t cambia in base allo stato di PREEMPT_RT.
>+
>+Sui kernel non-PREEMPT_RT, spinlock_t si traduce in un raw_spinlock_t ed ha
>+esattamente lo stesso significato.
>+
>+spinlock_t e PREEMPT_RT
>+-----------------------
>+
>+Sui kernel PREEMPT_RT, spinlock_t ha un'implementazione dedicata che si basa
>+sull'uso di rt_mutex. Questo ne modifica il significato:
>+
>+ - La prelazione non viene disabilitata.
>+
>+ - I suffissi relativi alla interruzioni (_irq, _irqsave / _irqrestore) per le
>+   operazioni spin_lock / spin_unlock non hanno alcun effetto sullo stato delle
>+   interruzioni della CPU.
>+
>+ - I suffissi relativi alle interruzioni software (_bh()) disabilitano i
>+   relativi gestori d'interruzione.
>+
>+   I kernel non-PREEMPT_RT disabilitano la prelazione per ottenere lo stesso effetto.
>+
>+   I kernel PREEMPT_RT usano un blocco per CPU per la serializzazione, il che
>+   permette di tenere attiva la prelazione. Il blocco disabilita i gestori
>+   d'interruzione software e previene la rientranza vista la prelazione attiva.
>+
>+A parte quanto appena discusso, i kernel PREEMPT_RT preservano il significato
>+di tutti gli altri aspetti di spinlock_t:
>+
>+ - Le attività che trattengono un blocco spinlock_t non migrano su altri
>+   processori. Disabilitando la prelazione, i kernel non-PREEMPT_RT evitano la
>+   migrazione. Invece, i kernel PREEMPT_RT disabilitano la migrazione per
>+   assicurarsi che i puntatori a variabili per CPU rimangano validi anche
>+   quando un'attività subisce la prelazione.
>+
>+ - Lo stato di un'attività si mantiene durante le acquisizioni del blocco al
>+   fine di garantire che le regole basate sullo stato delle attività si possano
>+   applicare a tutte le configurazioni del kernel. I kernel non-PREEMPT_RT
>+   lasciano lo stato immutato. Tuttavia, la funzionalità PREEMPT_RT deve
>+   cambiare lo stato se l'attività si blocca durante l'acquisizione. Dunque,
>+   salva lo stato attuale prima di bloccarsi ed il rispettivo risveglio lo
>+   ripristinerà come nell'esempio seguente::
>+
>+    task->state = TASK_INTERRUPTIBLE
>+     lock()
>+       block()
>+         task->saved_state = task->state
>+	 task->state = TASK_UNINTERRUPTIBLE
>+	 schedule()
>+					lock wakeup
>+					  task->state = task->saved_state
>+
>+   Altri tipi di risvegli avrebbero impostato direttamente lo stato a RUNNING,
>+   ma in questo caso non avrebbe funzionato perché l'attività deve rimanere
>+   bloccata fintanto che il blocco viene trattenuto. Quindi, lo stato salvato
>+   viene messo a RUNNING quando il risveglio di un non-blocco cerca di
>+   risvegliare un'attività bloccata in attesa del rilascio di uno spinlock. Poi,
>+   quando viene completata l'acquisizione del blocco, il suo risveglio
>+   ripristinerà lo stato salvato, in questo caso a RUNNING::
>+
>+    task->state = TASK_INTERRUPTIBLE
>+     lock()
>+       block()
>+         task->saved_state = task->state
>+	 task->state = TASK_UNINTERRUPTIBLE
>+	 schedule()
>+					non lock wakeup
>+					  task->saved_state = TASK_RUNNING
>+
>+					lock wakeup
>+					  task->state = task->saved_state
>+
>+   Questo garantisce che il vero risveglio non venga perso.
>+
>+rwlock_t
>+========
>+
>+Il blocco rwlock_t è un meccanismo che permette più lettori ma un solo scrittore.
>+
>+Sui kernel non-PREEMPT_RT questo è un blocco ad attesa e per i suoi suffissi si
>+applicano le stesse regole per spinlock_t. La sua implementazione è imparziale,
>+quindi previene l'inedia dei processi scrittori.
>+
>+rwlock_t e PREEMPT_RT
>+---------------------
>+
>+Sui kernel PREEMPT_RT rwlock_t ha un'implementazione dedicata che si basa
>+sull'uso di rt_mutex. Questo ne modifica il significato:
>+
>+ - Tutte le modifiche fatte a spinlock_t si applicano anche a rwlock_t.
>+
>+ - Dato che uno scrittore rw_semaphore non può assicurare la propria priorità ai
>+   suoi lettori, un lettore con priorità più bassa che ha subito la prelazione
>+   continuerà a trattenere il blocco, quindi porta all'inedia anche gli
>+   scrittori con priorità più alta. Per contro, dato che i lettori possono
>+   garantire la propria priorità agli scrittori, uno scrittore a bassa priorità
>+   che subisce la prelazione vedrà la propria priorità alzata finché non
>+   rilascerà il blocco, e questo preverrà l'inedia dei processi lettori a causa
>+   di uno scrittore.
>+
>+
>+Precisazioni su PREEMPT_RT
>+==========================
>+
>+local_lock su RT
>+----------------
>+
>+Sui kernel PREEMPT_RT Ci sono alcune implicazioni dovute alla conversione di
>+local_lock in un spinlock_t. Per esempio, su un kernel non-PREEMPT_RT il
>+seguente codice funzionerà come ci si aspetta::
>+
>+  local_lock_irq(&local_lock);
>+  raw_spin_lock(&lock);
>+
>+ed è equivalente a::
>+
>+   raw_spin_lock_irq(&lock);
>+
>+Ma su un kernel PREEMPT_RT questo codice non funzionerà perché local_lock_irq()
>+si traduce in uno spinlock_t per CPU che non disabilita né le interruzioni né la
>+prelazione. Il seguente codice funzionerà su entrambe i kernel con o senza
>+PREEMPT_RT::
>+
>+  local_lock_irq(&local_lock);
>+  spin_lock(&lock);
>+
>+Un altro dettaglio da tenere a mente con local_lock è che ognuno di loro ha un
>+ambito di protezione ben preciso. Dunque, la seguente sostituzione è errate::
>+
>+
>+  func1()
>+  {
>+    local_irq_save(flags);    -> local_lock_irqsave(&local_lock_1, flags);
>+    func3();
>+    local_irq_restore(flags); -> local_unlock_irqrestore(&local_lock_1, flags);
>+  }
>+
>+  func2()
>+  {
>+    local_irq_save(flags);    -> local_lock_irqsave(&local_lock_2, flags);
>+    func3();
>+    local_irq_restore(flags); -> local_unlock_irqrestore(&local_lock_2, flags);
>+  }
>+
>+  func3()
>+  {
>+    lockdep_assert_irqs_disabled();
>+    access_protected_data();
>+  }
>+
>+Questo funziona correttamente su un kernel non-PREEMPT_RT, ma su un kernel
>+PREEMPT_RT local_lock_1 e local_lock_2 sono distinti e non possono serializzare
>+i chiamanti di func3(). L'*assert* di lockdep verrà attivato su un kernel
>+PREEMPT_RT perché local_lock_irqsave() non disabilita le interruzione a casa
>+della specifica semantica di spinlock_t in PREEMPT_RT. La corretta sostituzione
>+è::
>+
>+  func1()
>+  {
>+    local_irq_save(flags);    -> local_lock_irqsave(&local_lock, flags);
>+    func3();
>+    local_irq_restore(flags); -> local_unlock_irqrestore(&local_lock, flags);
>+  }
>+
>+  func2()
>+  {
>+    local_irq_save(flags);    -> local_lock_irqsave(&local_lock, flags);
>+    func3();
>+    local_irq_restore(flags); -> local_unlock_irqrestore(&local_lock, flags);
>+  }
>+
>+  func3()
>+  {
>+    lockdep_assert_held(&local_lock);
>+    access_protected_data();
>+  }
>+
>+spinlock_t e rwlock_t
>+---------------------
>+
>+Ci sono alcune conseguenze di cui tener conto dal cambiamento di semantica di
>+spinlock_t e rwlock_t sui kernel PREEMPT_RT. Per esempio, sui kernel non
>+PREEMPT_RT il seguente codice funziona come ci si aspetta::
>+
>+   local_irq_disable();
>+   spin_lock(&lock);
>+
>+ed è equivalente a::
>+
>+   spin_lock_irq(&lock);
>+
>+Lo stesso vale per rwlock_t e le varianti con _irqsave().
>+
>+Sui kernel PREEMPT_RT questo codice non funzionerà perché gli rtmutex richiedono
>+un contesto con la possibilità di prelazione. Al suo posto, usate
>+spin_lock_irq() o spin_lock_irqsave() e le loro controparti per il rilascio. I
>+kernel PREEMPT_RT offrono un meccanismo local_lock per i casi in cui la
>+disabilitazione delle interruzioni ed acquisizione di un blocco devono rimanere
>+separati. Acquisire un local_lock àncora un processo ad una CPU permettendo cose
>+come un'acquisizione di un blocco con interruzioni disabilitate per singola CPU.
>+
>+Il tipico scenario è quando si vuole proteggere una variabile di processore nel
>+contesto di un thread::
>+
>+
>+  struct foo *p = get_cpu_ptr(&var1);
>+
>+  spin_lock(&p->lock);
>+  p->count += this_cpu_read(var2);
>+
>+Questo codice è corretto su un kernel non-PREEMPT_RT, ma non lo è su un
>+PREEMPT_RT. La modifica della semantica di spinlock_t su PREEMPT_RT non permette
>+di acquisire p->lock perché, implicitamente, get_cpu_ptr() disabilita la
>+prelazione. La seguente sostituzione funzionerà su entrambe i kernel::
>+
>+  struct foo *p;
>+
>+  migrate_disable();
>+  p = this_cpu_ptr(&var1);
>+  spin_lock(&p->lock);
>+  p->count += this_cpu_read(var2);
>+
>+La funzione migrate_disable() assicura che il processo venga tenuto sulla CPU
>+corrente, e di conseguenza garantisce che gli accessi per-CPU alle variabili var1 e
>+var2 rimangano sulla stessa CPU fintanto che il processo rimane prelabile.
>+
>+La sostituzione con migrate_disable() non funzionerà nel seguente scenario::
>+
>+  func()
>+  {
>+    struct foo *p;
>+
>+    migrate_disable();
>+    p = this_cpu_ptr(&var1);
>+    p->val = func2();
>+
>+Questo non funziona perché migrate_disable() non protegge dal ritorno da un
>+processo che aveva avuto il diritto di prelazione. Una sostituzione più adatta
>+per questo caso è::
>+
>+  func()
>+  {
>+    struct foo *p;
>+
>+    local_lock(&foo_lock);
>+    p = this_cpu_ptr(&var1);
>+    p->val = func2();
>+
>+Su un kernel non-PREEMPT_RT, questo codice protegge dal rientro disabilitando la
>+prelazione. Su un kernel PREEMPT_RT si ottiene lo stesso risultato acquisendo lo
>+spinlock di CPU.
>+
>+raw_spinlock_t su RT
>+--------------------
>+
>+Acquisire un raw_spinlock_t disabilita la prelazione e possibilmente anche le
>+interruzioni, quindi la sezione critica deve evitare di acquisire uno spinlock_t
>+o rwlock_t. Per esempio, la sezione critica non deve fare allocazioni di
>+memoria. Su un kernel non-PREEMPT_RT il seguente codice funziona perfettamente::
>+
>+  raw_spin_lock(&lock);
>+  p = kmalloc(sizeof(*p), GFP_ATOMIC);
>+
>+Ma lo stesso codice non funziona su un kernel PREEMPT_RT perché l'allocatore di
>+memoria può essere oggetto di prelazione e quindi non può essere chiamato in un
>+contesto atomico. Tuttavia, si può chiamare l'allocatore di memoria quando si
>+trattiene un blocco *non-raw* perché non disabilitano la prelazione sui kernel
>+PREEMPT_RT::
>+
>+  spin_lock(&lock);
>+  p = kmalloc(sizeof(*p), GFP_ATOMIC);
>+
>+
>+bit spinlocks
>+-------------
>+
>+I kernel PREEMPT_RT non possono sostituire i bit spinlock perché un singolo bit
>+è troppo piccolo per farci stare un rtmutex. Dunque, la semantica dei bit
>+spinlock è mantenuta anche sui kernel PREEMPT_RT. Quindi, le precisazioni fatte
>+per raw_spinlock_t valgono anche qui.
>+
>+In PREEMPT_RT, alcuni bit spinlock sono sostituiti con normali spinlock_t usando
>+condizioni di preprocessore in base a dove vengono usati. Per contro, questo non
>+serve quando si sostituiscono gli spinlock_t. Invece, le condizioni poste sui
>+file d'intestazione e sul cuore dell'implementazione della sincronizzazione
>+permettono al compilatore di effettuare la sostituzione in modo trasparente.
>+
>+
>+Regole d'annidamento dei tipi di blocchi
>+========================================
>+
>+Le regole principali sono:
>+
>+  - I tipi di blocco appartenenti alla stessa categoria possono essere annidati
>+    liberamente a patto che si rispetti l'ordine di blocco al fine di evitare
>+    stalli.
>+
>+  - I blocchi con sospensione non possono essere annidati in blocchi del tipo
>+    CPU locale o ad attesa attiva
>+
>+  - I blocchi ad attesa attiva e su CPU locale possono essere annidati nei
>+    blocchi ad attesa con sospensione.
>+
>+  - I blocchi ad attesa attiva possono essere annidati in qualsiasi altro tipo.
>+
>+Queste limitazioni si applicano ad entrambe i kernel con o senza PREEMPT_RT.
>+
>+Il fatto che un kernel PREEMPT_RT cambi i blocchi spinlock_t e rwlock_t dal tipo
>+ad attesa attiva a quello con sospensione, e che sostituisca local_lock con uno
>+spinlock_t per CPU, significa che non possono essere acquisiti quando si è in un
>+blocco raw_spinlock. Ne consegue il seguente ordine d'annidamento:
>+
>+  1) blocchi ad attesa con sospensione
>+  2) spinlock_t, rwlock_t, local_lock
>+  3) raw_spinlock_t e bit spinlocks
>+
>+Se queste regole verranno violate, allora lockdep se ne accorgerà e questo sia
>+con o senza PREEMPT_RT.
>-- 
>2.39.2
>

-- 
Federico Vaga

